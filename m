Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C782C433E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CFC32086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rA/hxPg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgHGTsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGTsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:48:12 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FB0C061756;
        Fri,  7 Aug 2020 12:48:12 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 185so3410607ljj.7;
        Fri, 07 Aug 2020 12:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/OAIwEYgb5EsnCOJBCBI53WQmoKNdPN9sFAT/HuBiGM=;
        b=rA/hxPg/cBBsL6bAS+rNWvYhRtIbOW7C8M0vmi2SgNiJ54zvP65TKyIbqD1hsHvkvS
         U7BsWvNlW0fM2g8crodJORaa+6xrZO4LAIxF70NhlT4aniLWsOt0YlH+H0rMWD5HVDjp
         e1z4CwOZtvwMokZdQ/+VXZFL5W6Br/QZsLGZ2kee1o1cxY3jJYjniQRvHWr2N8a6u1Ye
         gO5m4DCTLEyQREynj8UgTn4yeIpXn3G5IARwAXYRfTC1XCvskkeqBJzmjuzGTxE1bfA3
         EolmpKhPAKVepeb0TamsuYYEtxZEIk55G2gnn+CVXK/aFlXWvjlFJKBjFwsuU5mh13MT
         zvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/OAIwEYgb5EsnCOJBCBI53WQmoKNdPN9sFAT/HuBiGM=;
        b=dRUXKgacG9vOBjR29byo0USGqAzY5leZI5oZXHPRWML4PPCYMG/yFj7orbxgMXb8yn
         ODk3cYm2hYEl5gm7VJOUQqMeIUfsp3e4l8rdfTu2hcWon9HraRHxUVimZZfcyx9lspOt
         Rwl7ge/QI7P7c5sN9761DGrfqPER22pTiuNIX0kH0vRSLofdHWU1igbgYSryY403hLvp
         v2lSz/NH7hRFA2nfzcQZTytwNnKO7lLmDx/k/udQsblnu/7LCRU0ut0luDVylCRWFZ+0
         zVYuYzlg45G1Rmom3aWdRc5LBNOkLGb9/d9UmYZ0tZKnQoyNM8XDihP+eQZApVagfihF
         U/FQ==
X-Gm-Message-State: AOAM533Mt2glW2w2Dqzh0EHAgSs/FdyZlRrdpjy4oLmoIh8pkYILbHIv
        yBITH6fPfYSKZkF+bPtFqVI=
X-Google-Smtp-Source: ABdhPJzDPKqMkNqMCDgRhnAMLxrvo+wEVw3+nGA9tP5kHBSzcsRls18yvJQ+ewft2ZoRvQRTWzs36g==
X-Received: by 2002:a2e:b689:: with SMTP id l9mr6614535ljo.393.1596829690811;
        Fri, 07 Aug 2020 12:48:10 -0700 (PDT)
Received: from wasted.omprussia.ru ([2a00:1fa0:445c:7ae3:e9a3:2354:9467:4eca])
        by smtp.gmail.com with ESMTPSA id k4sm4171586ljc.50.2020.08.07.12.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 12:48:10 -0700 (PDT)
Subject: Re: [PATCH 5/7] ARM: dts: r8a7742: Add DU support
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
References: <20200807174954.14448-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200807174954.14448-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <e67a94e8-c9ed-dc9e-cab8-453a09441bcb@gmail.com>
Date:   Fri, 7 Aug 2020 22:48:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807174954.14448-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 8/7/20 8:49 PM, Lad Prabhakar wrote:

> Add du node to r8a7742 SoC DT. Boards that want to enable the DU

  Both "du" and "DU" on a single line? :-)

> need to specify the output topology.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
[...]

MBR, Sergei
