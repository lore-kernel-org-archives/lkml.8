Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79F9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA4020707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgHZLlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:41:20 -0400
Received: from foss.arm.com ([217.140.110.172]:44634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729011AbgHZLjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:39:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6FF51045;
        Wed, 26 Aug 2020 04:27:49 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 919993F71F;
        Wed, 26 Aug 2020 04:27:48 -0700 (PDT)
Date:   Wed, 26 Aug 2020 12:27:45 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Al Grant <al.grant@foss.arm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com, Denis Nikitin <denik@google.com>
Subject: Re: [PATCH] perf inject: correct event attribute sizes
Message-ID: <20200826112745.GB43491@C02TD0UTHF1T.local>
References: <b5f9e19c-6adb-ccdd-3dbd-df8e1b82ee93@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5f9e19c-6adb-ccdd-3dbd-df8e1b82ee93@foss.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 10:42:04AM +0100, Al Grant wrote:
> When perf inject reads a perf.data file from an older version of perf,
> it writes event attributes into the output with the original size field,
> but lays them out as if they had the size currently used. Readers see
> a corrupt file. Update the size field to match the layout.
> 
> From: Denis Nikitin <denik@google.com>
> Signed-off-by: Al Grant <al.grant@foss.arm.com>

Did Denis write this patch?

If so, we need an S-o-B line from them.

Mark.

>  tools/perf/util/header.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 9cf4efdcbbbd..762eb94bd532 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3326,6 +3326,14 @@ int perf_session__write_header(struct
> perf_session *session,
>         attr_offset = lseek(ff.fd, 0, SEEK_CUR);
> 
>         evlist__for_each_entry(evlist, evsel) {
> +               if (evsel->core.attr.size < sizeof(evsel->core.attr)) {
> +                       /*
> +                        * We are likely in "perf inject" and have read +
> * from an older file. Update attr size so that
> +                        * reader gets the right offset to the ids.
> +                        */
> +                       evsel->core.attr.size = sizeof(evsel->core.attr);
> +               }
>                 f_attr = (struct perf_file_attr){
>                         .attr = evsel->core.attr,
>                         .ids  = {
