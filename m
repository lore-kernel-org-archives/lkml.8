Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768B0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 02:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555D02067B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 02:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DbxjgyYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgFHCor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 22:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgFHCoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 22:44:46 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FFBC08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 19:44:46 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id j32so13555340qte.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 19:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=FPcz9YafDq1qtXpcZdMPyDLn3kmPXd/6a/ka09XlD6g=;
        b=DbxjgyYPgy+83sEuMM05Ktn+rvL5Sxf9DeHbRxI70b9NTCky2nkoxmnw8LMpSZRt0W
         IjRj5UPV2SfCKZAUXT4NdGo7BT0ivf7MaQA9st1D+6JZnlfWGjIKG/+D3znOsI+ki9x5
         3mUe05daFekaxRjD70QCHU66MwocIMKru9Ci8qG1HbRn4Cy5dJh1rGy1F8uBuETFB3ro
         OPA/KoHHoFjZOMMc7RLDZigkn6vx9i8StX+DbK/LF9wxj3uOlFBJPrC9ynVBSjwhibTR
         TH3CVhFBo10HWh/hzrBbkv3VAOqfbNHoUulbVW/0B+psz+JBIhbYO3FmgHP1VETJOe0N
         G5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=FPcz9YafDq1qtXpcZdMPyDLn3kmPXd/6a/ka09XlD6g=;
        b=jXki8J9hG2zaB89NrspjSp/YUbIWbtPO6QmSy9JFP45RRF+cP//5o5Yk7DkeGIwxQl
         lbW0ysSGK2TgVShkwaA08Fc+Vrxs9GysmF+Uqz1G1eL2do9m6s8bgdEYELjTzH/WqghJ
         UpU4Nx33DJL8AKNShtZMFtc2iqodzd3A+W3+75VSM3m56mHLeVWtpo3Qd//xXl7qEzbF
         QNWoHOZaH8QmoyCi4khSNGvPxyMp01eV57yJRBlpAwhkqjUvvzp/CCKAdcW60UaMxMVt
         80KoBMqoeKTrZ5+2vbk8fg6vUX6hhh2vncCCuxN9ymqV6GoaE9Wr8yBfGnBCbxmtdI2X
         p0DA==
X-Gm-Message-State: AOAM531EHhSX0CGflb0axPF0CjG6bT+Oz94ToTJK8RQIwNJPAvVfZHpv
        J4N2RTuBJEfChupQR8LPEU/AJA==
X-Google-Smtp-Source: ABdhPJzOnZMvbGJtixH027fSNPWPdCNG4SDNPkiojoKUt328YLGmo8Pyvi+u4Qv8XubOIu8igVkRGA==
X-Received: by 2002:ac8:4c8d:: with SMTP id j13mr21871617qtv.38.1591584285211;
        Sun, 07 Jun 2020 19:44:45 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v189sm5973771qkb.64.2020.06.07.19.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 19:44:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] drm/rcar-du: DRM_RCAR_WRITEBACK depends on DRM
Date:   Sun, 7 Jun 2020 22:44:43 -0400
Message-Id: <4E18C3DC-D418-4DEB-AC70-4FB6FCFDB5BD@lca.pw>
References: <20200608020207.GL22208@pendragon.ideasonboard.com>
Cc:     kieran.bingham+renesas@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200608020207.GL22208@pendragon.ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 7, 2020, at 10:02 PM, Laurent Pinchart <laurent.pinchart@ideasonboa=
rd.com> wrote:
>=20
> How about depending on DRM_RCAR_DU instead, as DRM_RCAR_WRITEBACK is
> used to select compilation of rcar_du_writeback.c that is part of the
> rcar-du driver ?

Sure. I=E2=80=99ll send a v2.=
