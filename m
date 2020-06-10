Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB19C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D5E2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgFJVIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:08:25 -0400
Received: from smtprelay0114.hostedemail.com ([216.40.44.114]:50876 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbgFJVIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:08:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id DAFF318029137;
        Wed, 10 Jun 2020 21:08:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: smile40_320491826dce
X-Filterd-Recvd-Size: 1830
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jun 2020 21:08:22 +0000 (UTC)
Message-ID: <fe98c147136c5625641d14bf70b13ffbfaeb025a.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add --max-file-size option
From:   Joe Perches <joe@perches.com>
To:     Scott Branden <scott.branden@broadcom.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 10 Jun 2020 14:08:21 -0700
In-Reply-To: <20200610205616.9965-1-scott.branden@broadcom.com>
References: <20200610205616.9965-1-scott.branden@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-10 at 13:56 -0700, Scott Branden wrote:
> Add --max-file-size option (default off) to limit size of files
> that checkpatch processes.  Such an option is useful when checkpatch
> is run automatically during checkins to a source control system and
> someone acccidently or purposely attempt to commit massive size files
> to the system.  If the checkpatch script runs on such files it could take
> a long time to run and limit the server's ability to perform other
> operations.

Does everything need to be in checkpatch or can this facility
be run by a separate script that does the file size validation
before running checkpatch?

Also:

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> +	if ($max_file_size > 0) {
> +		my $filesize = -s$FILE;

Does this work if the input file is from STDIN?
I'd guess it does not.

I think this might be better using (stat($FILE))[7]
or at least a space between -s and $file.


