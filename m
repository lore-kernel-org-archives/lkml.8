Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E356C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E44F208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgEHJ16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 05:27:58 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:55803 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgEHJ15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 05:27:57 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N0WwO-1jA6oq1HyG-00wVKc for <linux-kernel@vger.kernel.org>; Fri, 08 May
 2020 11:27:56 +0200
Received: by mail-qk1-f170.google.com with SMTP id n14so884172qke.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 02:27:56 -0700 (PDT)
X-Gm-Message-State: AGi0PuaMvPf4mKO3Pbw1FIny9qT/avyl9rlkqGLH7sh2pK5/LoA02iRL
        Iar01g2RAxv4eKRO7y+2X91HmH1Drzf+Y68OKFc=
X-Google-Smtp-Source: APiQypIT5KGAy6nduWP+f4Ah+CHDgMCWNiHI9NZ/Jg9NOh6Uos1ERK6OAeEd1eWPfJzvShL2GXArM5FV2hTFxejddLQ=
X-Received: by 2002:a05:620a:3c5:: with SMTP id r5mr1861152qkm.138.1588930075188;
 Fri, 08 May 2020 02:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0QkqyA2wq_EbA+oWrLGgVdQwpBvb+G0aKyz60BOLs6fg@mail.gmail.com>
 <20200507232941.jccuywl56bppxfyp@treble>
In-Reply-To: <20200507232941.jccuywl56bppxfyp@treble>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 8 May 2020 11:27:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0pY+tu=3hvWTZVwD7nbA7UhaaCGWbBVba0eDuNcpt2Sg@mail.gmail.com>
Message-ID: <CAK8P3a0pY+tu=3hvWTZVwD7nbA7UhaaCGWbBVba0eDuNcpt2Sg@mail.gmail.com>
Subject: Re: objtool warning breaks build for fs/dlm/lock.o
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:XVGLGx9hS5I3qn1xMKGlp0QdSoZ9iP/hTcbUyFD6l89JJgbgbX9
 gGzi+AT58wbWE7p4aOHyzcja1xJskQHBWubCN3A2EFS/fNWF0fuPglZDU56wWVXVXU1cUgp
 D6+1OcLEo7p7kFv/YH+tKaBRtUFhhqOaK6BxB/48qv1nvZPttbWbf5kgHb4R2INaQ097//I
 xioMwON9OjBN5nEEGO8Yg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U6QLziOnm0s=:YpL0QRtPZAjfvfAoL23iDh
 XY7+BVIILKDLnpxPgu0BOUD1fPfHFjpT4MxVAamJjw6axSyZ0fmuEf+LlOcgqkz4HWMPLbUCZ
 tCXCiyAA06iGTIPJx9ZBwnADvhtABy+egPcYR4NzaZg0o9S1iwGzN+vUNIxOjG3GFsp6fc5sw
 SdSeOH7xb1PmKntmHG+W+yW6f/IQW/TcnUjVf8sVQTRawFBqj1/8FE1v0OGpSv/sS+h6eauDD
 sDjgKjD7KVsAyf0nQo13DXoWO2+TtGGiieQGJkzqi/nYYjraCFEWMIHf9Bf5bqh5eI1uaL0jt
 q6J44mcLJ27gClHI37Jr3Hnaw0/zkP7utDUSBcYu8ETjixVML0jMGRIgCswwvRizVrekAORu0
 L7junExFjB0LDJmJUVgF9nEeifiifXM9DDIuU3UCKDSQ6DY69mOS0CS2f27oQEZ0RRmxs0IwY
 EwCGPVGn0KU1dtYbiWJfCWoUovJDcev6e3LWPHvMY/v9dS4b87jUtrrUSoOdltLXr0V3P1sMl
 4GGBVWghFb/N76K39PyvqD8zjyTIeOFw0Awv2V2bOicLv7NxTiFhwgsc5eiiZ1/TJFGe9mZAD
 h87oALMhYLwsqrmSeM+76pcwdTYRBG8Gl/bXQ0/ftVxdAkks8ANSBx/Ly05kBFLei5zqHw+cf
 oi/v44z7lsVGz/dBv1daqoNSk8a5mK8kL3VPY8o4eZmVQvzQYI1Cyww31X3gqsn+sAAS8aVTH
 jdZUppo0RWXCNfYL3XgqxiH+UrsFQXuCXylhTrRTumn2VZxVMNG9LvyMkmzEILxFb1AxOMJ02
 MZjWFYPSZZRKaMaEisEs4lV/p+KR5qwIkfaTQc9rUJZ9MFMSq4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 1:29 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, May 06, 2020 at 04:07:25PM +0200, Arnd Bergmann wrote:
> > Hi,
> >
> > During randconfig testing with clang-10 I came across a number
> > of additional objtool warnings, I'll send another mail about those
> > when I have collected more information and some object files.
> >
> > This one sticks out however, as objtool returns an error code that
> > stops the build:
>
> > fs/dlm/lock.o: warning: objtool: __receive_convert_reply()+0x1e5: can't find jump dest instruction at .text+0xcaa7
>
> Thanks for sending the patch for this one.  Objtool always gets confused
> by new compiler versions, I really think we need to revert
>
>   644592d32837 ("objtool: Fail the kernel build on fatal errors")
>
> because objtool is never going to be reliable enough such that we can be
> confident that failing the build is the right thing to do.

Right, makes sense. It would be nice though to have a way of intentionally
turning all objtool warnings into errors. I do my randconfig tests
with '-Werror'
at the moment in order to catch all new warnings, but this does not catch
objtool errors at the moment. For now, this is probably the right thing to do,
as there are a couple of warnings that I have no patches for, but at some point
I would prefer to trap immediately when a new warning pops up.

     Arnd
