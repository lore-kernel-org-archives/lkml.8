Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62CFC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F26E20769
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586453872;
	bh=bWPm9mWtVoXwBBWBeiO7m3SgRGdn5YJdwHwEMOFrtCo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2LDhdyZTOiwpfmhknLS1uixQLKaDJw1PRmsRq5sucxSMuj7amklZGxsgVjo8bk+DG
	 x1pupkcn0FbzHPzWm4FiYW2K7Ta65sLH1riG6T+4C4ETRvDItgeh6Xfb4svcnidNW8
	 zugP1NBZIZ2KN1DRGA6aicrXNLQpGKItbjX/tPk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgDIRhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:37:50 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42690 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDIRhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:37:50 -0400
Received: by mail-lf1-f65.google.com with SMTP id s13so262136lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 10:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5M3TUW/uqkQ9nzkgoCZB6YmFX0QEbW7fqBTk+QTVkl4=;
        b=VG6avlXSsCDkNYI5/uf6Ycn5jWuGZAfGa23n74dVR9RhdIRT5v5v+mcoFGvT02rZRK
         iyL26MmmQmB1yt5RWPojSRYGM81FKcMi2PikGIpKRm1J6JLv7Q4xJ26+wk8PJ6hdCAbB
         xpK/OAH5V7JZSHGuyl78Lieyv3sV9SqBm1GsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5M3TUW/uqkQ9nzkgoCZB6YmFX0QEbW7fqBTk+QTVkl4=;
        b=rJt+u+p+3o9nNh/9364Oitp3lWWLCThhN7BzjBxVPylxP1rQPEKlhJ5NFO7fkyVlDU
         JRTzDWMBVch1EwyLEBGdeOh9ioKsQODXdefRroXc5CBrdCYjAmy/Rz6jLTrKBEYxvB56
         P937Uuj+i6bdbMvp1abQiKVJFbcPYxFGzrsgMIeL2HnIj75DnCK6cg2sbnvtG/qJLtNj
         0ge9bVNc1nNXMIyHdOSfhadnnWkYMCpjHuZNt2dPNVJwtToFkyi/fbWj3GaoJ3z8sF6P
         hCdCrH8ACQB+0ypArQp5OH5BjFE1Im0oQr+WqZr9dxjgYIw7hZw+YEX3cOemSR4frRov
         ojeg==
X-Gm-Message-State: AGi0PubeglYFrErUW64AMHbPpYnHHa1aLFwZmbKhdF0arBVbQMqDgrMF
        OGVheMgnxHGNfCmy+tVxG4m5w/UNWig=
X-Google-Smtp-Source: APiQypK3jQZ+f2J5q5Im2up+9Ja53pph5r+gYXazKH/XFLnSDHc9aSvwsPtyLsHLKbDrzTrfZf6+Mw==
X-Received: by 2002:a19:992:: with SMTP id 140mr237865lfj.41.1586453868358;
        Thu, 09 Apr 2020 10:37:48 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id l7sm18580436lfg.79.2020.04.09.10.37.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 10:37:46 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id r24so575566ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 10:37:46 -0700 (PDT)
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr565472ljp.204.1586453866116;
 Thu, 09 Apr 2020 10:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org> <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <87blo45keg.fsf@x220.int.ebiederm.org> <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
 <87v9maxb5q.fsf@x220.int.ebiederm.org> <CAHk-=wih4BqW7GTLaYxewynuT-iFHrXroip0wNo0CyPtmYGUow@mail.gmail.com>
 <87y2r4so3i.fsf@x220.int.ebiederm.org> <CAHk-=wjhAvv6s_7OVeZJiHaY7bBrHyiPTkSpq-TLr6qxYqxUUw@mail.gmail.com>
 <CAHk-=wi0jrKv9x6vJ9FDgTrSUbdbZYDX-79T-E87C48MGSn5=g@mail.gmail.com>
 <87wo6or3pg.fsf@x220.int.ebiederm.org> <AM6PR03MB51708FD4226E07AB7CB0D6A7E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB51708FD4226E07AB7CB0D6A7E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Apr 2020 10:37:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjaoYM4gXdAyYY=u8PaYj2LXUvcfp=8DKum8f1DM+Ws0A@mail.gmail.com>
Message-ID: <CAHk-=wjaoYM4gXdAyYY=u8PaYj2LXUvcfp=8DKum8f1DM+Ws0A@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 10:17 AM Bernd Edlinger
<bernd.edlinger@hotmail.de> wrote:
>
> Just for reference, I used Oleg's test case,
> and improved it a bit.

I'm sure the test-case got posted somewhere, but mind sending it to me
(or just pointing me at it?)

             Linus
