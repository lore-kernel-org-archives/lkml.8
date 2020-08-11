Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EAFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71CDB20658
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Owbomwry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgHKLkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbgHKLkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:40:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3D6C061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 04:40:21 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ep8so1739294pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 04:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yz4TcW9rTup6J1JHf4cL+vgG/kmFz0aHv9ruePdNsKs=;
        b=OwbomwryuHmiOn5hy7eYtGyiClOiCcWJDWxsATng2SfBZjNv4F+rhN++srWChEOyIp
         IIbTu2KcACM8Io/5U+ed1Px+/yOuzl70Ed3jMBW/OjicT0u+ynAN6xcCrGSNpnrub1gb
         6kkxQCekx2kYh+Y3vxmeBHHLXi+Foh3S6MVum2Os+Qidchsd2LxSHOFbQYhV26IXzL9u
         WBCK3pXjTHbkE5ed3HrxO4Xc/a6R4L6jtqa7yHC5AfwbIBJhcn64A7ipDVSLZ4D3vuOJ
         T2B+jy7BOYY8QBro7gxWbDiG9Ir0yDSBXVCanb3s9t5A6SYmNgq2KvDOxKhOdSUjYbGY
         1uXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yz4TcW9rTup6J1JHf4cL+vgG/kmFz0aHv9ruePdNsKs=;
        b=LYL8SZ0tUtux8h3hJdoj8egKxFHd7X/UdCkWYYoRdZxQmBpukD9NQ6XZjmbOBKOjLZ
         1RMRY8J9ltYCFps9JCe7U0B1GJKGVAqbktwVrF/X66+0NIcEMj/rqrO90twq7FUkLxKS
         MobJPBM2arNkteq81L0XVneykkrLtx4TA4QFUgD/Cn05GtqVAdI0YKRzejouu+1F6Qr1
         IRz/zFbquD8Sf8W1Auap8qf94eug9VQY5fEMPlfEB32bjXQHqEcfdbMWgmBjDR8XhuFR
         7O7pekeIPBAupwS3LsnL+nfQDidgs/FhR4i3+W3+3SL8jDcvIPEisMBiXJLjfZNj/14i
         aChg==
X-Gm-Message-State: AOAM5306b8iAqP8RAuAgKpQ/t2Emh6DfQLIxy/boQmaK1uI6yqaz5hRI
        e4+SmiMsQY71IQvBswt0qPo7Cg==
X-Google-Smtp-Source: ABdhPJxBcA3xjSg7J7I1G+dD1OTi46lk8vkw86E5QUA7ZoYDypIkJGMn79PaN++6AgEprAKWBFDtFg==
X-Received: by 2002:a17:90a:77c9:: with SMTP id e9mr654872pjs.142.1597146020082;
        Tue, 11 Aug 2020 04:40:20 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id gj2sm2600448pjb.21.2020.08.11.04.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 04:40:19 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [RESEND PATCH v3 0/2] Add support for Tianma nt36672a video mode panel
Date:   Tue, 11 Aug 2020 17:10:08 +0530
Message-Id: <20200811114010.17807-1-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Poco F1 phones from Xiaomi have an nt36672a video mode panel; add support
for the same.
Most of the panel data is taken from downstream panel dts, and is converted to
drm-panel based driver by me.
It has been validated with v5.8-rc5 on Poco F1 phone; my tree with other
dependent patches is here [1]

[1]: https://git.linaro.org/people/sumit.semwal/linux-dev.git/log/?h=dev/poco-panel-upstreaming

---
v2: In dt-binding, removed ports node, making port@0 directly under panel@0 node.
    Also updated the panel_on delay to a safer 200ms as needed for latest Android.
v3: Replaced port@0 with just port in panel@0 node.

[1]: 

Sumit Semwal (2):
  dt-bindings: display: panel: Add bindings for Tianma nt36672a panel
  drm: panel: Add tianma nt36672a panel driver

 .../display/panel/tianma,nt36672a.yaml        |  95 ++
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-tianma-nt36672a.c | 859 ++++++++++++++++++
 5 files changed, 973 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-tianma-nt36672a.c

-- 
2.27.0

