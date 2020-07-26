Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBF4C4346B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 12:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEE9F2065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 12:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rU77LQ6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgGZMxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 08:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGZMxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 08:53:33 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B39C0619D2;
        Sun, 26 Jul 2020 05:53:33 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a9so7716367pjd.3;
        Sun, 26 Jul 2020 05:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R4T7tQMcRvlhK7jzS9wpJG+H4i1GMckJZWYDGHoH/II=;
        b=rU77LQ6i8gZi61P3L9deG+VaqhuXUapmjk1algjVPC2JSElAiPIN/5qEGgW38mfTnj
         QAX7dULkwcwM6Ubq5rMyHZsOsi4GSWpYDtUCAt5fVozNjLCfpbA9MQy5fD90PADw/mka
         QepdRFrkGRoT+DQDXJnHe0qwyJ5zifDt9SQeCav2jscmmAFfU5a7fGVZQKdcr8Ocl9kV
         IxxVrcZluClcwuEl9Di+lcSeqBmbw42UN9IwJezMGs2v/kRpGPn42zDHTyVWK7dVm9uW
         UCJ1dtoem9CCYI39A0ajsZlt26ESpArPyPRcYNnHgnuvcbey0juBUIOljbZb499WWeJT
         AXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R4T7tQMcRvlhK7jzS9wpJG+H4i1GMckJZWYDGHoH/II=;
        b=oKu1VNwSlLGA6ikAXfaZN7bf3h7FnFYWVycelq7Ri4IwG26HAzb0O9eus4xDZ8q4Hf
         jkmqptU4Squr0X+GQ8+S5pVs7DxI2jyK7OyqeXx5ni81wgRCvaC4CjdGgLGqzE7mQcUp
         QCs/GnkYgAdaMgDQI4rYHqZ3IQKx5Qd6oTNhcvxtEQFm/a7eyfQRpJrb/CesUW80yr9Y
         IHd5xnngYiqYZIPqPPF+Ws0dBIpcqxI+Va17VLKhCzrba6023eB8k6ThhvroFpU27X/u
         bkJLl5hs9Jj1acKaTmwaz9WKHoYzgDpSSGkHUgWi/QbYk7SQkpW3Abh02l0eLbjmXlov
         1eUQ==
X-Gm-Message-State: AOAM532BPBeYJOKJIcgmMo4SPtZJIuyVLfpn/WozWStRMIPMlQIjQ1M9
        vX8TNbDXoxXX4glnXqoOxiTZBMbx6t4=
X-Google-Smtp-Source: ABdhPJy+XjmUnqWgwhLFuieksNeTmaaDQA6UZSj6j+mjeRVxWyBNwf/r/1Tb+sxOqJMyku2EF7qUyA==
X-Received: by 2002:a17:902:8f8b:: with SMTP id z11mr14408279plo.49.1595768012739;
        Sun, 26 Jul 2020 05:53:32 -0700 (PDT)
Received: from localhost (g155.222-224-148.ppp.wakwak.ne.jp. [222.224.148.155])
        by smtp.gmail.com with ESMTPSA id x7sm12033589pfq.197.2020.07.26.05.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 05:53:32 -0700 (PDT)
Date:   Sun, 26 Jul 2020 21:53:25 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Wei Xu <xuwei5@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] io: Fix return type of _inb and _inl
Message-ID: <20200726125325.GC80756@lianli.shorne-pla.net>
References: <20200726031154.1012044-1-shorne@gmail.com>
 <CAHp75VciC+gqkCZ9voNKHU3hrtiOVzeWBu9_YEagpCGdTME2yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VciC+gqkCZ9voNKHU3hrtiOVzeWBu9_YEagpCGdTME2yg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 12:00:37PM +0300, Andy Shevchenko wrote:
> On Sun, Jul 26, 2020 at 6:14 AM Stafford Horne <shorne@gmail.com> wrote:
> >
> > The return type of functions _inb, _inw and _inl are all u16 which looks
> > wrong.  This patch makes them u8, u16 and u32 respectively.
> >
> > The original commit text for these does not indicate that these should
> > be all forced to u16.
> 
> Is it in alight with all architectures? that support this interface natively?
> 
> (Return value is arch-dependent AFAIU, so it might actually return
> 16-bit for byte read, but I agree that this is weird for 32-bit value.
> I think you have elaborate more in the commit message)

Well, this is the generic io code,  at least these api's appear to not be different
for each architecture.  The output read by the architecture dependant code i.e.
__raw_readb() below is getting is placed into a u8.  So I think the output of
the function will be u8.

static inline u8 _inb(unsigned long addr)
{
	u8 val;

	__io_pbr();
	val = __raw_readb(PCI_IOBASE + addr);
	__io_par(val);
	return val;
}

I can expand the commit text, but I would like to get some comments from the
original author to confirm if this is an issue.

-Stafford
