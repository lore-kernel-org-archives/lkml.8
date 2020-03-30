Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE808C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 05:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A366E20786
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 05:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiEGw8DK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgC3FmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 01:42:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44581 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgC3FmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 01:42:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id m17so19941082wrw.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 22:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3P0V5vj1YGa/Uboo6dNVxif8ueivaoTLzVUM3s36xNY=;
        b=DiEGw8DKOdiDb3Un+b4ZUEoTCXq10qSQazD18bUfWN7boqsTN7Yp/2Wo0g1+1xPI0R
         SGZ2TlrHaY7EPce6YX41LVqlRjZYWH01Ecx4BfUDg2y818vbVbqqAG0ne7KNH/SroQAV
         AZcfxV0SfeuO5HXMaTKjfwe4/EisnxKbLZVAl4Qvw6q+QE0pmQ20AYHVIReR5FeM6zLH
         Nquevvg563hmsFAw1ToJ5LDkI1Ck5Kkx3evPri+phjeoHrVB6JfCV/JEPuUHLUZwvIei
         Dc+g7+9ewHCSAq9uPZrzl/P0GFtt4KTGgGjk4iJ0S7ugjqqqaiTKv8DumVHLlLxrkWiy
         FyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3P0V5vj1YGa/Uboo6dNVxif8ueivaoTLzVUM3s36xNY=;
        b=lBp7/euezrQq6DRi5dh7CeNTyidCqpXGGSjX/ApIGtM3XYE0greJIV5Hv3VrGepa57
         OjtxTegRbo2MQpwurUp+DFDWsCsqoVnIIdvTRR8UqHqTuIQKBZZQGGEh2joCePakqoWK
         aH7fLd/2LigjJEdnMZdIhOINM2pMVYX8xMVoQ6U/zpXQimIn/HM+9TE+uvHf4liKIYxk
         coTC23GkAo7/MBwNy4rtwJBBOGknKhFfAVeRHqQQ368Vs2mWx/+HcZcuUBgjAYuaZqIN
         H68ZDuCl+QHbpd5iHtdHqwokBZ7fD7aRLuKfHDewJTjS/CY/Q0HudG83XasltVTjLgWe
         P5Mg==
X-Gm-Message-State: ANhLgQ0k46Rq0wUQX7RyUXVlrAeiUswjTbYNK9OKuS/sJGt5ytdAS1a3
        wpXWYPEE8PNKcDbaIsUPzA==
X-Google-Smtp-Source: ADFU+vtjN3crOb6WmkqLmmbtl+gcwMveMv+ZydqurNGw8owz8DOBVwCvDivJi8D+k+qFCdhxbAmTdA==
X-Received: by 2002:adf:9d88:: with SMTP id p8mr12829166wre.257.1585546926427;
        Sun, 29 Mar 2020 22:42:06 -0700 (PDT)
Received: from avx2 ([46.53.249.42])
        by smtp.gmail.com with ESMTPSA id u5sm23662648wrp.81.2020.03.29.22.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 22:42:05 -0700 (PDT)
Date:   Mon, 30 Mar 2020 08:42:03 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     masahiroy@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: drop support for GCC <= 4.7
Message-ID: <20200330054203.GA328@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This commit drops the plugin support for GCC <= 4.7 a bit earlier,
> which allows us to dump lots of code.

4.7+ allows _Alignas, _Alignof, _Static_assert even in --std=gnu89 mode.
Very nice.
