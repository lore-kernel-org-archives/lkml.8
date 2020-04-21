Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51905C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A96F206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgDUPCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:02:48 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:54438 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgDUPCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:02:47 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jQuQA-0003ce-To; Tue, 21 Apr 2020 09:02:46 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jQuQ8-0006pm-IY; Tue, 21 Apr 2020 09:02:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christof Meerwald <cmeerw@cmeerw.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200419201336.GI22017@edge.cmeerw.net>
Date:   Tue, 21 Apr 2020 09:59:39 -0500
In-Reply-To: <20200419201336.GI22017@edge.cmeerw.net> (Christof Meerwald's
        message of "Sun, 19 Apr 2020 22:13:36 +0200")
Message-ID: <87v9ls51gk.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jQuQ8-0006pm-IY;;;mid=<87v9ls51gk.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19wSpoVnHs/NK3Cbc2PgMStLu6JhH5zp24=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: SIGCHLD signal sometimes sent with si_pid==0 (Linux 5.6.5)
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christof Meerwald <cmeerw@cmeerw.org> writes:

> Hi,
>
> this is probably related to commit
> 7a0cf094944e2540758b7f957eb6846d5126f535 (signal: Correct namespace
> fixups of si_pid and si_uid).
>
> With a 5.6.5 kernel I am seeing SIGCHLD signals that don't include a
> properly set si_pid field - this seems to happen for multi-threaded
> child processes.

Christof I want to say very good spotting and reporting of this issue.

Thank you.
Eric
