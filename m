Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2457BC4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F022020722
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e73vgvqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgCSHbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 03:31:24 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:44772 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgCSHbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 03:31:23 -0400
Received: by mail-io1-f53.google.com with SMTP id v3so1179366iot.11;
        Thu, 19 Mar 2020 00:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jomgdCLpahd3FAv2npbYPI8+FQ6XSFwP0NwoJcIKrDI=;
        b=e73vgvqvEk9vZ1wrZML1M7ZRhdJPyQbn3ASJuasCtdVSk4d6DVOILSLWkLdgCvOFru
         KpGdOKO0M9xNtv2NLG2c4t+hHkEuPMIL6Ynr1IW61Arfphb9TVvOlNXp3GVgtQjZIfNU
         pXZr/QdwafVJDpQoEH3YZrlhbnZsamS7APlvzqH7SoF+mvRYQpzSMyGcXIho+f3bA2zx
         R8YVhjwUboS+zCc9x8oQXTA21BQHDcpWeG8//5Nu16f6UpRY/GogKoI45vMPSYXKPoHX
         yXkuT2yuc/mWUTGqYCHWUkCdlGVqcTxzJalSJlRNs5WCTGx9lz8KwwRHCQCOdUeyL7eI
         2X/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jomgdCLpahd3FAv2npbYPI8+FQ6XSFwP0NwoJcIKrDI=;
        b=RbpLjpMv+hjG2tgRKQy+Y7aNdsYKcKL2y6KR6jL89kC8r3QgEfCp7X7zTCFT1rk1KW
         nMLHYKu9tBDe+NTWD96i9YD/BQVWMaJ45piBKuOKpLvOFZYjvQzVSETrKh1PIOdlSFrh
         JF1APQRTl2EUd+kBpMjtPxUEuxK8ZSTYTKn+Zu3iqfWi5NUJdT2gklD5g2V142bqgRjX
         rQLkDMMJ2PrjNp+0+83Zact2ZVXFMQsx01oIFBlipK3ncqQVBjD90tL5sAY3g99ROmpk
         ClSl4ImwekXChmxn0+CnnCSNUJPmnCFjfPFDcX5nuuNR2N3YXWJOgRKS7pHozN31+ov5
         8IDQ==
X-Gm-Message-State: ANhLgQ1vFhqRY2TfdyiPJx4mLQ34FyurMxyAsmHGmX11UUM24RQf1VjX
        ZHI1FNx+qXEn0w7AT/qXiSXMmqci9nWPNY9TZHwtjszL
X-Google-Smtp-Source: ADFU+vv6bG3YgVuAvhITGXQ3/8y6DKdabygw3bmdHZm6PMcbVAy6NA+GKIaxrmykbd76jG9NytI3zjUmCE1DIZxCIqE=
X-Received: by 2002:a02:7f44:: with SMTP id r65mr1962710jac.26.1584603082412;
 Thu, 19 Mar 2020 00:31:22 -0700 (PDT)
MIME-Version: 1.0
From:   Vinay Simha B N <simhavcs@gmail.com>
Date:   Thu, 19 Mar 2020 13:01:10 +0530
Message-ID: <CAGWqDJ7AccvoxjKfQJ3GytJ-+u56Bk3rEn0sSYv-zCuBe1brAg@mail.gmail.com>
Subject: graph connection to node is not bidirectional kernel-5.6.0-rc6
To:     "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I am getting the endpoint' is not bidirectional(d2l_in, dsi0_out)
warning in compilation, built boot image works on qcom apq8016-ifc6309
board with the dsi->bridge->lvds panel.
Because of this warning i cannot create a .yaml documentation examples.
Please suggest.

tc_bridge: bridge@f {
status = "okay";
    ports {
    #address-cells = <1>;
    #size-cells = <0>;

    port@0 {
        reg = <0>;
        d2l_in: endpoint {
            remote-endpoint = <&dsi0_out>;
        };
    };
};

dsi@1a98000 {
    status = "okay";
...
    ports {
        port@1 {
            dsi0_out:endpoint {
                remote-endpoint = <&d2l_in>;
                data-lanes = <0 1 2 3>;
            };
        };
    };
};

https://github.com/vinaysimhabn/kernel-msm/blob/1cbd104cca4ebfb111c92e939ca09f82aac00aa1/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
https://github.com/vinaysimhabn/kernel-msm/blob/08e4821646b5c128559c506a5777d8782f1ff79e/Documentation/devicetree/bindings/display/bridge/toshiba%2Ctc358775.yaml

arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi:253.28-255.9: Warning
(graph_endpoint): /soc/i2c@78b8000/bridge@39/ports/port@0/endpoint:
graph connection to node
'/soc/mdss@1a00000/dsi@1a98000/ports/port@1/endpoint' is not
bidirectional
arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi:333.53-335.35: Warning
(graph_endpoint): /soc/auo,b101xtn01/port/endpoint: graph connection
to node '/soc/i2c@78b8000/bridge@f/ports/port@1/endpoint' is not
bidirectional

-- 
regards,
vinaysimha
