Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EDFC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F09624655
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579802576;
	bh=QlTBNP6TZNzi2X5VtLqQmjrH8iIvqT1D0WMVKVLJ0Q4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iOHCTfsBBIxfXe5q7jCZ2YegepuxT+Xq40vGyxTWljtfLnAk7l3VG+tAdAuzaY+oR
	 XD1pW5VlewjdxfLN02CiwAPV3mxhPjhstqT5kwX4KEVu+wEujiUNWefQCgu7feDeBo
	 oZmvhLNDGJRQiL/Wk3jMILAsaQwyemzP05FO0rqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgAWSCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:02:55 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38151 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgAWSCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 13:02:54 -0500
Received: by mail-lj1-f195.google.com with SMTP id w1so4601924ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 10:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDGhNOsnfRqZ1FkvFFgvc9AjFE5Ddur1Pg9CKAfnAxU=;
        b=R8rUnlTAVJ23suSGKIAk3x/NWMyIV1571Zyk795MWw02ibpxnwpaVKBgIpemglXFyP
         UyAn/M4pPrtxudOzb1Yimjimwf7PBh+D79Avp2N7YtdpAxKItUKS5GifZRNjNI8G6ljo
         pty5cnSbJVgpFW0/1axLB6FvRc4gFKR+F0mc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDGhNOsnfRqZ1FkvFFgvc9AjFE5Ddur1Pg9CKAfnAxU=;
        b=F8z74mr/Rcl1/mUAcTcKSeeifiOXqVWfAnTXAT44BLiFk3nvOTHVlAAyvMAj+I4Vh9
         RUOHmtV332CarnXZfQB1/10b4SFxH8+FGM2oGAO1YSKd1ckOUuaEBgvXyuko/pWV8S6Z
         GuhZdRAMnVCe8ruC0/h8eoRFTaZwm6GwjrUOrL9aXkYgIJqKXsNQZPNPxLQKUxl1gND2
         FmX3QzZZFUNtoW67BinZj6vSZIcEeFPIDaRBdMS0kbPIBRxEfXlPGgRsZ8ezgyD1Fsz+
         UG+3tJ0eX39IZStdY+kQqsqjLklJcpw2J6SHwdeigot+A+2xrfpZIRefC8d0+V9qqR8o
         5mrA==
X-Gm-Message-State: APjAAAWihUOvf0a63KDitTdNt2Mi+oa1pWbq1e95mHvoYKi7oH+/uy/3
        z1kG1HGXqa23Mk1silNQ9+iGGH9Rws8=
X-Google-Smtp-Source: APXvYqw+6uLLR8MqOx+EGvqOjfuMTYpF98lYZBp3jqq9zH4vTvCceVRBF/5hld1RyyYfAjrI9KGuwA==
X-Received: by 2002:a2e:94c8:: with SMTP id r8mr24299472ljh.28.1579802571087;
        Thu, 23 Jan 2020 10:02:51 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id r21sm1700435ljn.64.2020.01.23.10.02.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 10:02:50 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id y6so4636965lji.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 10:02:50 -0800 (PST)
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr23878285ljo.41.1579802569766;
 Thu, 23 Jan 2020 10:02:49 -0800 (PST)
MIME-Version: 1.0
References: <fed4f49349913cb6739dac647ba6a61d56b989d2.1579783936.git.christophe.leroy@c-s.fr>
 <e11a8f0670251267f87e3114e0bdbacb1eb72980.1579783936.git.christophe.leroy@c-s.fr>
In-Reply-To: <e11a8f0670251267f87e3114e0bdbacb1eb72980.1579783936.git.christophe.leroy@c-s.fr>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Jan 2020 10:02:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg4HEABOZdjxMzbembNmxs1zYfrNAEc2L+JS9FBSnM8JA@mail.gmail.com>
Message-ID: <CAHk-=wg4HEABOZdjxMzbembNmxs1zYfrNAEc2L+JS9FBSnM8JA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] uaccess: Tell user_access_begin() if it's for a
 write or not
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 4:59 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> On 32 bits powerPC (book3s/32), only write accesses to user are
> protected and there is no point spending time on unlocking for reads.

Honestly, I'm starting to think that 32-bit ppc just needs to look
more like everybody else, than make these changes.

We used to have a read/write argument to the old "verify_area()" and
"access_ok()" model, and it was a mistake. It was due to odd i386 user
access issues. We got rid of it. I'm not convinced this is any better
- it looks very similar and for odd ppc access issues.

But if we really do want to do this, then:

> Add an argument to user_access_begin() to tell when it's for write and
> return an opaque key that will be used by user_access_end() to know
> what was done by user_access_begin().

You should make it more opaque than "unsigned long".

Also, it shouldn't be a "is this a write". What if it's a read _and_ a
write? Only a write? Only a read?

                    Linus
