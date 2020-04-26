Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992D4C55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A069206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HM/d4nA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgDZQVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 12:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726146AbgDZQVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 12:21:23 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B59CC061A0F;
        Sun, 26 Apr 2020 09:21:23 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c23so11743353qtp.11;
        Sun, 26 Apr 2020 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XZJ5XFJS/vsNAYaNowFEvXY/ZczE3nivx6mZjGNsaaU=;
        b=HM/d4nA6P4W/GTAy4y/pD3qJ0N8A8PSV/jvQSLm6y1qWH5cXsuSoIGv9bzLKssIdoQ
         ormeLE2uNOCvwRF/fQIHHhh8HDSCpcAF8695nXugKI37Z+zCu/Rjhd8IxpmY92b2LJMv
         zu7M7I9XhSVnTVTt3BJ3i/ISzfLv13TdtvTdYNBz22Ff4kNEd6EdXOZGbDW6ljANZdaT
         Erycz54Xrf0HZkJ1tvZyGgXT5/02m8mMjC1CkLvGdCbN+l+UvFjjN8Vo4cOazRCobp5K
         BO5amkDIZ51xAW/gHeKTSGPinsOJa0DeYlQtmTFHLQFz7BXqsQRWepPRO0vl3BDL1BXx
         um9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XZJ5XFJS/vsNAYaNowFEvXY/ZczE3nivx6mZjGNsaaU=;
        b=FJt18pGqg6ZQhf/9rjfVD6cjq6YMIvpADCWOMXH1U1S3IFmbHX5FQtUnZndWLk+LgO
         vP8KPl6rHW/aNkCZRtBlyi2lN8XiLB4h3YjIuvNg4+Pyy0KBJZxIveWEEIsti35rk6DZ
         pubqoTZkdS7pEjF+8OPqQFTnrOTMqxZBOI+q859UmWvm559mkFQOtquj9hvVxfKYGwA+
         FvRJVHxb9SnSAAJK2SMfX/2HYxM61KOUQ9OYsBiygDBYWbnAZGqwF674uQIpbGTmQyjD
         YHAhZ488xDGn6NxBQ27Ac/DvDdIshXNLGF2QzhvI84JHzZizKV6BqoCkYREOZ+CTJ7c3
         6itw==
X-Gm-Message-State: AGi0PuaZcNZgBC5VJx4niL7lsqYfRikKiqgGvY4mmLN5PHCGpDtZqyMS
        0BWS3ygzSXzOSq9xxvO4lZc=
X-Google-Smtp-Source: APiQypLJGSjAIL6gY5u9MQHOt1jpAYtXqbnJciek4pGiJF7wy6uTwL+CxOxvOZqvu/ws+fVRLdD2PQ==
X-Received: by 2002:ac8:3459:: with SMTP id v25mr18842584qtb.229.1587918082412;
        Sun, 26 Apr 2020 09:21:22 -0700 (PDT)
Received: from imac (dhcp-108-168-12-59.cable.user.start.ca. [108.168.12.59])
        by smtp.gmail.com with ESMTPSA id z18sm7991005qti.47.2020.04.26.09.21.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Apr 2020 09:21:21 -0700 (PDT)
Date:   Sun, 26 Apr 2020 12:21:19 -0400
From:   Tim Lewis <elatllat@gmail.com>
To:     elatllat@gmail.com
Cc:     narmstrong@baylibre.com, khilman@baylibre.com,
        christianshewitt@gmail.com, joy.cho@hardkernel.com,
        tobetter@gmail.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org
Subject: [PATCH v4] arm64: dts: meson: S922X: extend cpu opp-points
Message-ID: <20200426162119.GA23268@imac>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add extra cpu pop points to allow mild overclock on S922X. The opp
points are found in Hardkernel N2 sources [1] and testing shows no
obvious issues on other S922X devices. Thermal throttling should
keep things in-check if needed.

[1] https://github.com/hardkernel/linux/commit/f86cd9487c7483b2a05f448b9ebacf6bd5a2ad2f
Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Tim Lewis <elatllat@gmail.com>

---
 arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi | 15 +++++++++++++++
 1 files changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
index 046cc332d..1e5d0ee5d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
@@ -65,6 +65,11 @@
 			opp-hz = /bits/ 64 <1896000000>;
 			opp-microvolt = <981000>;
 		};
+
+		opp-1992000000 {
+			opp-hz = /bits/ 64 <1992000000>;
+			opp-microvolt = <1001000>;
+		};
 	};
 
 	cpub_opp_table_1: opp-table-1 {
@@ -120,5 +125,15 @@
 			opp-hz = /bits/ 64 <1704000000>;
 			opp-microvolt = <891000>;
 		};
+
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <981000>;
+		};
+
+		opp-1908000000 {
+			opp-hz = /bits/ 64 <1908000000>;
+			opp-microvolt = <1022000>;
+		};
 	};
 };
-- 
2.17.1

