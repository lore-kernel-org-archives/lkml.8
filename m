Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B87C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B4620730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586292485;
	bh=a05UYOnt62RQr+EE+Q1nTgEu1qSHCBk6Xf9LfiGCkDs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LPgRihJLKC/FnuGtjO4kYnH6mIuRE0iuc09IwFenvg2a6ADNl9L334SHgC5mm7tPI
	 1uPiRPcrUCJZX1wEGi4F7xAcPfkqonLuutCeGihCWXRe/ECDpyMwkBKK4KBjSREIXO
	 mVLTsM8HcLhpC3GX/JH3APPaAv/lhEQlxv0v5cvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgDGUsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:48:04 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40464 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgDGUsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:48:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id 142so733774ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 13:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0HjyJmpuP/fheL56eiDsEL3j2Jeu/bd9xUqsyeAAnTM=;
        b=FQhyz95ErvyUTVGyfMDMjF6va9oPn5G9QQis7cMRsGgxDIlUsuR1VPQIJcvsMd+KCq
         0iP/0/T9Jmk7j6bVuyAPuFSmCHiQ0xIfFLAeu2pHJH+OZduD+lXrUxG4XnL+i0voL1YP
         rrIyxNCOOm8Hwt3UhNhsZTM7/H0hggIN/mxg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0HjyJmpuP/fheL56eiDsEL3j2Jeu/bd9xUqsyeAAnTM=;
        b=JP9+oZXgLK/cRztn3TyssbpTOyt4FuH/PTxTYsnTmxw7JIni8RTXI2H3yoLoNNX6G3
         8v/QC3pKBYstqX/UXNrvZy+pbnwluuPfw7VqZdCY1dCPCJNNMh5LvUcruZiJkFG7wmk+
         NuROIycrtwfdBMQLaoIargXO9h5swQfFKgcpPYocR6ePMRI0W8LIg51JRBoeOxnJdBkl
         aEDTGsyn+V2lKv61zna0lZYTTZ1EN9slWCagY14sbn3NhoTH2UrWRaLtzhKpJHg6xWF6
         hYx6zK4Jt4nj5q33zN23RRdBrPFiG2BAEln2AcIBhmJh0iEtbvcoBQRfAOOUQIPE+1oL
         Nktg==
X-Gm-Message-State: AGi0PuasaAK9Y3PXuiFisYLv06Ag9frGR8s1s4ejg90to5NjDcEy7XWw
        im7hA+4HfSaD44JcW8+xhZmMBtunmM4=
X-Google-Smtp-Source: APiQypL4G/+xD4DTFNlPJWRl7zy3Ii4bz+kI8xwAsD8O01hQouE/5T6m8UV9PQWXaqitO77zkF3d6Q==
X-Received: by 2002:a05:651c:22e:: with SMTP id z14mr2768735ljn.64.1586292480080;
        Tue, 07 Apr 2020 13:48:00 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id i2sm150899ljb.50.2020.04.07.13.47.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 13:47:59 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id g27so5237500ljn.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 13:47:58 -0700 (PDT)
X-Received: by 2002:a2e:8911:: with SMTP id d17mr2932028lji.16.1586292478505;
 Tue, 07 Apr 2020 13:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org> <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <87blo45keg.fsf@x220.int.ebiederm.org> <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
 <AM6PR03MB5170FA8CACA7A1BB2026F55EE4C30@AM6PR03MB5170.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5170FA8CACA7A1BB2026F55EE4C30@AM6PR03MB5170.eurprd03.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Apr 2020 13:47:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibSLkDSW-5jqyXoaSN-pi9bQVAFtcyZfgYGxBaRp4E4Q@mail.gmail.com>
Message-ID: <CAHk-=wibSLkDSW-5jqyXoaSN-pi9bQVAFtcyZfgYGxBaRp4E4Q@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 1:29 PM Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>
> Maybe, actually I considered this, but I was anxious that making something
> that is so far not killable suddenly killable might break other things.

I don't think it can.

Basically, if you have a execve() and a setprocattr() racing, one or
the other starts first.

And if the execve() started first, then the setprocattr() thread would
get killed by the execve(), and there's no serialization. So you might
as well just say "it got killed before it even started to wait".

So semantically, having a killable wait is basically exactly the same
as losing the race - which wasn't ordered to begin with.

It's not like anybody will see the return value - the thread that
would have gotten the value got killed.

So doing

    if (down_writel_killable(&credlock))
        return -EINTR;

may *look* like it's new semantics, but it isn't really. That EINTR
error isn't visible to anybody, and everything looks absolutely
identical to "execve() in the other thread started earlier and killed
the thread even before it got to the system call".

              Linus
