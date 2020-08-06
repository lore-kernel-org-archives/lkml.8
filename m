Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01321C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B55B2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tPu6mV20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgHFTLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFTLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:11:49 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F622C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 12:11:49 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id c16so31121456ejx.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 12:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YMctw0ntOGXtEYEmNa4wOmRsQpzdo87we+KhxYWUSKg=;
        b=tPu6mV20XQtLFZMttNdw3X1s1g+87/8CgjSYPajdnW7ErmnNlNYj+9jTfSf1XySghi
         WGIDhuaF4U2HzmYAG2ah9UsmzvN/isj2o5MiXyEpdHmmDANVs7OA/ITs+ATGfOn5sL5n
         89Q0F0GjabIZl/52sKNXqnUqWWibRncuobEa46Jjq/5N3GM5fcE2Xmj6LxK7omEc4Fb3
         XEQwjSlLudcRFt3IqgCAbFwtSen8r83wAMjjjivkjlcx41D2cg7GVBs4ef1aPD1W5XF7
         tVSz81/7TfDYRpvapuDo8IFhlobYEx2QSh0UVBDI3fRX7Wqswt0uMzX099WYKSdAqy44
         8lsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YMctw0ntOGXtEYEmNa4wOmRsQpzdo87we+KhxYWUSKg=;
        b=NZS4CCchbw2Izsfc5SELawDxkaFKv2s+3Fld5jUkqc+nBRbWvhZHCl/u2C90e6hFvj
         VeT0FVwnHCeqmuiNJnZuOm4WCtypZvlzQowd4DqVnUrapOHDoblLnz8J6jGsNK57aWOb
         DO/FryVdLqI6IRwoq9uE7nSK88Nf3MYTfoO2BlMH2R6RnCYDUK3KmGbaMux/8aOuEif5
         +gH+tF1nqQk3n0gAaJS1ls9OVqIQt84POLDuyCLowpO+oFeDbZ2jUjt0LZZqgexizpaS
         07CI0wPlmsJMgUrEsjFcBihur/p6cBLWaqVck1veQJ3AEm9UMFNG9M7h2hyW1KU8LnQR
         TLLw==
X-Gm-Message-State: AOAM531tVlEuzLdYLQnBw0X3pstv+OJrnKZwqyKcHwXGuMi/6KD4P/wU
        sX5Ng2V7P8CckLtzJ0kDRnI=
X-Google-Smtp-Source: ABdhPJyqHA3/6AB5cxfDKtXw62Hbp9nIRpNTiHNkBPfcY/ZRL6O/sbnt/mEt1DaQoxNj6GI6aShZ7Q==
X-Received: by 2002:a17:906:71d3:: with SMTP id i19mr5741367ejk.459.1596741108245;
        Thu, 06 Aug 2020 12:11:48 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:d567:ec52:e0a5:f485])
        by smtp.gmail.com with ESMTPSA id b62sm3999408edf.61.2020.08.06.12.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 12:11:47 -0700 (PDT)
Date:   Thu, 6 Aug 2020 21:11:46 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] OpenRISC header and sparse warning fixes for 5.9
Message-ID: <20200806191146.36xlfjwehe5lorav@ltop.local>
References: <20200805210725.310301-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805210725.310301-1-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 06:07:19AM +0900, Stafford Horne wrote:
> Hello,
> 
> Changes since v1:
>  - in "io: Fixup defines and move include to the end" added a linux/types.h
>    include as there were compiler failurs pointed out by kbuild.
> 
> This a series of fixes for OpenRISC sparse warnings.  The kbuild robots report
> many issues related to issues with OpenRISC headers having missing or incorrect
> sparse annotations.

The changes look quite good to me (I just add 2 nits for patches 5 & 6).

Fell free to add my
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
