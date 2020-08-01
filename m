Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88C5C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 18:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0AF0206E6
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 18:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgHASzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 14:55:47 -0400
Received: from smtprelay0250.hostedemail.com ([216.40.44.250]:32812 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726534AbgHASzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 14:55:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id D684A18224D61;
        Sat,  1 Aug 2020 18:55:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lock15_30178ef26f8e
X-Filterd-Recvd-Size: 1511
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sat,  1 Aug 2020 18:55:44 +0000 (UTC)
Message-ID: <91c6c45f0d8ec0d031c216711cd8d7f6e9aad7ad.camel@perches.com>
Subject: Re: [PATCH 2/4] audit: uninitialize global variable audit_sig_sid
From:   Joe Perches <joe@perches.com>
To:     Jules Irenge <jbi.octave@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        "moderated list:AUDIT SUBSYSTEM" <linux-audit@redhat.com>
Date:   Sat, 01 Aug 2020 11:55:43 -0700
In-Reply-To: <20200801184603.310769-3-jbi.octave@gmail.com>
References: <0/4> <20200801184603.310769-1-jbi.octave@gmail.com>
         <20200801184603.310769-3-jbi.octave@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-01 at 19:46 +0100, Jules Irenge wrote:
> Checkpatch tool reports an error at variable audit_sig_sid declaration
[]
> diff --git a/kernel/audit.c b/kernel/audit.c
[]
> @@ -125,7 +125,7 @@ static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
>  /* The identity of the user shutting down the audit system. */
>  kuid_t		audit_sig_uid = INVALID_UID;
>  pid_t		audit_sig_pid = -1;
> -u32		audit_sig_sid = 0;
> +u32		audit_sig_sid;

All of these are unused outside of audit.c and might as
well be static and removed from the .h file.


