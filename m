Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EB2C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54DE206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgDGQYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:24:49 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:51364 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgDGQYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:24:49 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jLr1q-0007kn-CT; Tue, 07 Apr 2020 10:24:46 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jLr1p-00012A-LW; Tue, 07 Apr 2020 10:24:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
        <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
        <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
        <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
        <87lfnda3w3.fsf@x220.int.ebiederm.org>
        <CAHk-=wjuv_J+2KOi+Fhr_nBKYf5CXr76DQKThA3uxXm3rCC3Uw@mail.gmail.com>
        <87wo6s3wxd.fsf_-_@x220.int.ebiederm.org>
        <87imic3wtz.fsf_-_@x220.int.ebiederm.org>
        <20200407161706.l5zfgghwr3p4vz2c@wittgenstein>
Date:   Tue, 07 Apr 2020 11:21:57 -0500
In-Reply-To: <20200407161706.l5zfgghwr3p4vz2c@wittgenstein> (Christian
        Brauner's message of "Tue, 7 Apr 2020 18:17:06 +0200")
Message-ID: <87h7xv1d22.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jLr1p-00012A-LW;;;mid=<87h7xv1d22.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/9gZcSDonlOVUHsWDJfD7KVLL35dBpU6M=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 2/3] exec: Make unlocking exec_update_mutex explict
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Mon, Apr 06, 2020 at 08:31:52PM -0500, Eric W. Biederman wrote:
>> 
>> With install_exec_creds updated to follow immediately after
>> setup_new_exec, the failure of unshare_sighand is the only
>> code path where exec_update_mutex is held but not explicitly
>> unlocked.
>> 
>> Update that code path to explicitly unlock exec_update_mutex.
>> 
>> Remove the unlocking of exec_update_mutex from free_bprm.
>> 
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Yeah, assuming that I didn't miss any subtleties just now.
> By "explicit" I assume you mean not conditionally unlocked, i.e. we
> don't need to check any condition in free_binprm().

Yes.  Not conditionally unlocked is what I meant.

> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Eric
