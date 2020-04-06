Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52815C2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CAF20768
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="bSjg+S5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgDFWJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:09:54 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45652 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgDFWJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:09:53 -0400
Received: by mail-qk1-f194.google.com with SMTP id o18so15195850qko.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 15:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=gIe8CkLjM82wDUUleKDpjwdoMMyk404Cqic4JU9Nero=;
        b=bSjg+S5s9dw1lm4JVKtoxcEC0us/Dz3yySWlk0kXzH0pfe6LwjY5LRiWDpPwKmNdLQ
         IFcCcERwJX97e/R/CqsDHJ65IkA+Fa/yGFMs9uW21KG6zxmWyB7VXyMAhB9GeP9MM8Zv
         aqCmjCB18+K+Aqu7cf2tDXZG1CtGJ6U6aKeuGS0gQylCCNsx2+C2R1pcGiqLauQ67wUw
         rDw4vYWthwd3JVsGnaWMTIcHC93ftfEqK8rD9C2kUyC/sqaO85eaYLQMdgdcItvfEDL7
         IO0hxYyUDb3TJ53eMVw5dzS2cFcxK72mQFaRTpztu9zBkH6TniwXZygMq66c3UDXAlP7
         O2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gIe8CkLjM82wDUUleKDpjwdoMMyk404Cqic4JU9Nero=;
        b=EvQyGA7lvxODscbigmfjUtoRnYfqGFi5ezb/5O4t1xaKhMjxz/+PpbUJhb6DqWkL+f
         gYfP09nhMHanq48i0ScACIio9HgauF/KjO/kBx6cilaAzMj+Qrtv7uZujI8oASAJgQxQ
         rhQjmwCEe28u8FtkDiwLZo+mnHB4+Hhqjr+JP2DqkobHNde8VJEPRjOFEGw3kAonPCea
         /x3MajpVuJm+/ca3WzuDxAvPdp6DWKXy11fXfGN7LP52uc5nktSCfcOoOVsuuWVSjYLD
         9VK/uFvaCDwPSboV4TKKPS5S6A1g54Vd2rMbnRE0FrwJEAasCSiAxL+AOBtWHVKswjZy
         dz1A==
X-Gm-Message-State: AGi0PuajN3UoUOwhHmUTrUEVyYVpbstd1P6Dea9EJ303n30gdQwqyBym
        YLgnrcyK1hyw47xWhqr/zXIxSA==
X-Google-Smtp-Source: APiQypIwoRkcP3Q7jH+/lYhUjs6IyMIdwndWokuXoN8e9IyOmyvKF9OBaJWBTF2HZflWMyOS71+cKw==
X-Received: by 2002:a37:583:: with SMTP id 125mr11379230qkf.351.1586210991809;
        Mon, 06 Apr 2020 15:09:51 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id x66sm10581544qka.121.2020.04.06.15.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 15:09:51 -0700 (PDT)
Message-ID: <def1997964b04f73fe7eeae5c20b5109ee2094df.camel@massaru.org>
Subject: Re: [PATCH v2] kunit: Fix kunit.py run --build_dir='<foo>' fails on
 "unclean" trees
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Mon, 06 Apr 2020 19:09:48 -0300
In-Reply-To: <CAFd5g47Ot-MfxzYmU8kfxpfv2pWhgb_2WigouuHnPT+20Ejk_w@mail.gmail.com>
References: <20200401013639.16388-1-vitor@massaru.org>
         <CAFd5g47Ot-MfxzYmU8kfxpfv2pWhgb_2WigouuHnPT+20Ejk_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-06 at 11:12 -0700, Brendan Higgins wrote:
> On Tue, Mar 31, 2020 at 6:36 PM Vitor Massaru Iha <vitor@massaru.org>
> wrote:
> > Fix this bug: https://bugzilla.kernel.org/show_bug.cgi?id=205219
> > 
> > For some reason, the environment variable ARCH is used instead of
> > ARCH
> > passed as an argument, this patch uses a copy of the env, but using
> > ARCH=um and CROSS_COMPILER='' to avoid this problem.
> > 
> > This patch doesn't change the user's environment variables,
> > avoiding
> > side effects.
> > 
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> 
> Sorry for the delayed reply. I had two people finish up on my team
> last week and I needed to do some things for that. You now have my
> undivided attention.

np

> So, I tried to apply this patch and it still doesn't apply on
> kselftest/kunit. At this point, basing your changes on
> torvalds/master
> would be fine since kselftest/kunit just got merged for 5.7.
> 
> Can you use the --base branch option when you send your next revision
> so I know what branch you are working against (just to be sure)?

Sure, I'll do that.

Thanks!
Vitor


