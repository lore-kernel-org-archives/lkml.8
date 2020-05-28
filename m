Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EC7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183E12075A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590693597;
	bh=C2bjNbD+5mIOqp2P7xQ7gKeEus5H2gwsMekwynE6zXA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zSaWp9Pz78SUtSADnnvP9LG/wiYyVISng5EDnCZ+LFXZ98kEcw1aymfQwVFeX0ybI
	 sP63bdIHz+qgZOkHDMNFVCC8Kg3M+97TteZaDSJ6zE38RfIsW8E+1wYccpicPL6yA3
	 JuiDfanfMgF7JvAzAYRW0SfOY6ZCzhFTeuI/QZNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406283AbgE1TTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406174AbgE1TTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:19:51 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEC7C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:19:51 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c11so32692187ljn.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tXlOeBf65Yp/6+PYQ/Z9dU3rb5mmnB5fZhc6BFlghL8=;
        b=Ov16wjFjaWguOkasn4nII0ijglrU3+OtQR6YIUxtzgdjczhR53GIDLYdX2Ud5H6s15
         ESTVoCZ2J1sFDQCI2eFnXOIPmdcn91ROMSyAUtXYgy7SvXWaW78+Za9U4KxtI3DoEBA0
         LKqf4jSgi5lcQf6E8bem7624bpLp+5UoHp/dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tXlOeBf65Yp/6+PYQ/Z9dU3rb5mmnB5fZhc6BFlghL8=;
        b=WFwjpQXDTkV7XoLSgnDv2Ysl3KmzeeQS/N721L4ojrp90M/N+ZaMpcdxnrFHdz9zLq
         M5bnBqtGTM9/6jw2TKFnZcXDOledQzLvgwfEm3tQpgTsdU9a1WTmmX9SvREfKQVdId9F
         oJSYCX7B/e1N7Tnx9b10og2LV+0to4NmE2677VSuAUI6t+SitDaYKhT6KC08oJr5pNTG
         Fwj1RJOgyV2TXOFOiPqSsqHe88xTwtlRBHcY2KWq2Bx8BL8JcVpm4QxAPx+GppBALdL5
         9uBM2t5qabAIVObbpdLZXKwJyScuzPwGOginsjeYZlkv1UVMK5CiMfIgGtStQ9OT5ZXm
         j0aA==
X-Gm-Message-State: AOAM533zJwvO/EmIh3P71L2mL7GFl2OyjwhGZ5im/s30BfbFBB0CElGx
        xEEN9xBVdm+IYsw5W00aWup1WlgUHgA=
X-Google-Smtp-Source: ABdhPJwSX0lpO6NTUUGide9BBYgfHmjVZg5uSsSLy7SX6/NL0+Nvon34BABcEHKmEd9UmdNpoLt2EA==
X-Received: by 2002:a05:651c:304:: with SMTP id a4mr2274667ljp.46.1590693589652;
        Thu, 28 May 2020 12:19:49 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 1sm1782825lft.95.2020.05.28.12.19.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 12:19:48 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id e4so12372648ljn.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:19:48 -0700 (PDT)
X-Received: by 2002:a05:651c:2c6:: with SMTP id f6mr2174859ljo.371.1590693588214;
 Thu, 28 May 2020 12:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200527213447.GH23230@ZenIV.linux.org.uk> <20200528070255.GA790247@gmail.com>
 <CAHk-=wgXqVTGA-HrzJZ_yboLrtQ4rK-qoz8AfwLV=PT7ke4fbA@mail.gmail.com>
 <20200528190555.GO23230@ZenIV.linux.org.uk> <CAHk-=wi3dVgSn8xMC2Uqs8aahFfeqO0Wue2KqxnDYrbBM+6uZQ@mail.gmail.com>
 <20200528191712.GP23230@ZenIV.linux.org.uk>
In-Reply-To: <20200528191712.GP23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 12:19:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsZ_en9wEwk+VuAGMXACcSDCYhMD-GmQER0snpp9S6yg@mail.gmail.com>
Message-ID: <CAHk-=whsZ_en9wEwk+VuAGMXACcSDCYhMD-GmQER0snpp9S6yg@mail.gmail.com>
Subject: Re: [git pull] coredump infoleak fix
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:17 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Might make sense to change the summary of that pull request to something
> like
>         make sure we don't forget to report the xstate components that happen
> to be in init state - both for coredump and for PTRACE_GETREGSET

Note that this has nothing to do with x86 per se.

It's more about ->getregs() being a horrid interface, and being easy
to get wrong in general. The fact that xstate is complex is just one
such trigger.

              Linus
