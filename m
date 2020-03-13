Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A589C5ACBF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CC720746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vvMDVjCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgCMLwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 07:52:43 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35647 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgCMLwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 07:52:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id v15so7199021qto.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 04:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8cRWFjyCHf4GbZngel1T0mk3vG3kUKL4H8h3Gu1F5vc=;
        b=vvMDVjCvFZRY94q/QctMHV4zqZKu/fniPXWxclWBr/efdOMn9B1AkRJYokIsXwJBtl
         0BZX6gyJu0sF/jwMULqmshOuGP0gTF1vDC0T3gW0Pgw0gkLzFQ9p0YifRI/hJFyyoVa3
         w/Rd2Hb2WKT1x8alCcCx40ln9bbVCmSKx7MwFJ7VWH8GbdGpovM+sGerMFop2xTM0ZoD
         EcIlgw0Exb1PPtV28vo+UxQfhaX6+HUrEumiizshiZENCj3lyXR1BA8ytNIwB050MT4Y
         KuwFOd3upDiwE3ymO6eNVgsJ8RnXPQTyNbPSUY/AK49VSbX8nBb8kt5jDWwT1ewDXefI
         F/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8cRWFjyCHf4GbZngel1T0mk3vG3kUKL4H8h3Gu1F5vc=;
        b=i865oaphyxsVH+UHFB2M6MkFjY4XR0JNyvAU+JXzXAAG4yvkKlUudT+JutOdy/FcHn
         H9FPOr5pU6aKUdu3pI+l3l7oBk6oIPWb8OM084eXnjzqOm0i4RKsG8XBjufrAIYOfBAK
         hPlA0TryCgLcsSB0FsjvTSvyPD8We4jXd9/NgCpTR4h8R+DHoE0Q9B+3VoIHzX691fr+
         xCkJAXs3K/AvKtqiTXEzYZ6PUq1MY4ojWmCDRA8NXoFpQaEZCu2WcIA0Izzi/6VSE97V
         HMamJMU7pXolf6jk35sgqO4T9eOyE5JEhkn+1pYFtNwlws9AXbomzQbmrpCKVMltyv20
         w5nA==
X-Gm-Message-State: ANhLgQ0K7LUdFwtA5rEQ85vLPZYe4T6Mi0aNZUPEYl0IHiRNQrOUrSCn
        qwYQM+hcCkFC+VUT/0tCJoR0tg==
X-Google-Smtp-Source: ADFU+vsWGdut+OD1aT3cywZs4Qd0ImcH4W8QDnCl8GceUnkjxcV8rOm5RbBlWtSGE2uu8nqZngvqyA==
X-Received: by 2002:ac8:4b4e:: with SMTP id e14mr11973622qts.144.1584100362009;
        Fri, 13 Mar 2020 04:52:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id 199sm11031143qkm.7.2020.03.13.04.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 04:52:41 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Miller <davem@davemloft.net>,
        David Dai <daidavid1@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: sdm845: add/update IPA information
Date:   Fri, 13 Mar 2020 06:52:35 -0500
Message-Id: <20200313115237.10491-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn, these patches implement the DTS changes required for the
Qualcomm IPA driver to support the SDM845 SoC.  The first adds the
basic IPA information, which would be needed for kernel versions
prior to v5.7.  The second updates the interconnect providers as
required because of this commit:
  b303f9f0050b arm64: dts: sdm845: Redefine interconnect provider DT nodes

David Miller has reverted the first of these from net-next.
  https://lore.kernel.org/netdev/20200312.154852.115271760293062652.davem@davemloft.net/

As agreed, please apply these to the Qualcomm tree if you find them
acceptable after review.  They are based on the qcom/arm64-for-5.7
branch.

Thanks.

					-Alex

Alex Elder (2):
  arm64: dts: sdm845: add IPA information
  arm64: dts: sdm845: update IPA interconnect providers

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 52 ++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

-- 
2.20.1
