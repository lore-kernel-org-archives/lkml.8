Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555C1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 349F420760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgFJUVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:21:34 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33832 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgFJUVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:21:34 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jj7E3-0000Ye-35; Wed, 10 Jun 2020 14:21:31 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jj7E2-00080u-Ef; Wed, 10 Jun 2020 14:21:30 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     syzbot <syzbot+4abac52934a48af5ff19@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <20200610130422.1197386-1-gladkov.alexey@gmail.com>
        <20200610183549.1234214-1-gladkov.alexey@gmail.com>
Date:   Wed, 10 Jun 2020 15:17:22 -0500
In-Reply-To: <20200610183549.1234214-1-gladkov.alexey@gmail.com> (Alexey
        Gladkov's message of "Wed, 10 Jun 2020 20:35:49 +0200")
Message-ID: <87eeqmzne5.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jj7E2-00080u-Ef;;;mid=<87eeqmzne5.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18c/i2m4LzZvVR3NXfr4aSXpqcWLF2oyW0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2] proc: s_fs_info may be NULL when proc_kill_sb is called
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> syzbot found that proc_fill_super() fails before filling up sb->s_fs_info,
> deactivate_locked_super() will be called and sb->s_fs_info will be NULL.
> The proc_kill_sb() does not expect fs_info to be NULL which is wrong.
>
> Link: https://lore.kernel.org/lkml/0000000000002d7ca605a7b8b1c5@google.com
> Reported-by: syzbot+4abac52934a48af5ff19@syzkaller.appspotmail.com
> Fixes: fa10fed30f25 ("proc: allow to mount many instances of proc in one pid namespace")
> Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>

applied

Eric
