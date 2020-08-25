Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCF2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 210FD2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="dUzGSIj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgHYQVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgHYQVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:21:11 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC31C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 09:21:10 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d19so7156374pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 09:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=L2oKOEupV27qICvhHWyDiF7Etr6coIqCr/1x6dmqhP8=;
        b=dUzGSIj7hwNgocfGDBX79TyuBWGD/fOm2Tg3Linokc59X0xu1MFMlmTbNgfGTy728H
         BdFE9PK3BVmeSzVuTlgnN53gSvnKvh9fS3mj7jGA2iZOsU1hhN4pIXHGs/JHtEk9cTmE
         FlEgt5s48sUOt/2X/olt0GRPSUg6ygVgvAiTmbiOEBpSP/a8sEbBASJ7otw07bfGV7gS
         MVA4xqoviXvU7lGMR6R587gy4jgLUBV9M8QV3Lj14ZGlZURKsqJtP0qdU88/Q4teVjUi
         Ie6nU3Zeq3C9ErwtB8wgQ5MxzDJQrcXiDyYuRHX76mNcCg+b2+icUn3keM2LOhjNxtQx
         yLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=L2oKOEupV27qICvhHWyDiF7Etr6coIqCr/1x6dmqhP8=;
        b=rEePzNbtQaU6QG9s5u9qpTlFduBflUlYIR7cOK93HshlvQnY6upik3SPckC+3ToWd7
         2XrQRe04ljYxLb69MbO3BkaZJmj6Tk3edijBThzSjco4S660DhDLfGZQWEkoMjMR0IFG
         p7zr/mDwc73qe9uGrezVBrwg7bmFI778gUxlGug2h2M4rv165e7s/ldB0JFKnfcSjqaW
         w+K6cHDc5ykED3wMwRZ66HaF7Exb5lQPScQR2nB2uBf3tGeVmiKTkLT7IyTewXrJJ0ME
         nuzG/E2Aw+o8UrRFV5lzFsoTsvAeAJcVTzKvLFJV8c7hBBBoepJFbC2TiCZ3TKsnZvlG
         a1fg==
X-Gm-Message-State: AOAM531op/SQTirXQcWapRRaboO+eSF7eJgKydb20v899FyhqrVwcFST
        IIlLGZm82euQUTFeLVW71dlyiA==
X-Google-Smtp-Source: ABdhPJwebpb1N/6mwKYVqcIkEX1j6oogLtgxeUyZeXL3dpd734Qx9PxxGJc0uVXs+W09T/PfruA5eg==
X-Received: by 2002:a17:902:16b:: with SMTP id 98mr8256384plb.23.1598372469704;
        Tue, 25 Aug 2020 09:21:09 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d128sm15020864pfa.24.2020.08.25.09.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 09:21:09 -0700 (PDT)
Date:   Tue, 25 Aug 2020 09:21:09 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Aug 2020 09:21:08 PDT (-0700)
Subject:     Re: [PATCH 0/3] SiFive DDR controller and EDAC support
In-Reply-To: <20200825161958.GE12107@zn.tnic>
CC:     yash.shah@sifive.com, robh+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, mchehab@kernel.org,
        tony.luck@intel.com, aou@eecs.berkeley.edu, james.morse@arm.com,
        rrichter@marvell.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, sachin.ghadi@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     bp@alien8.de
Message-ID: <mhng-a19106aa-1a18-4fe0-b8c1-9c765f03f73d@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020 09:19:58 PDT (-0700), bp@alien8.de wrote:
> On Tue, Aug 25, 2020 at 09:02:54AM -0700, Palmer Dabbelt wrote:
>> Thanks.  These look good to me and I'm happy to take them through the RISC-V
>> tree, but I'm going to wait for a bit to see if there are any comments from the
>> maintainers of the various subsystems before doing so.
>
> I'll have a look at the EDAC bits these days and give you an ACK if
> they're ok.

Thanks!
