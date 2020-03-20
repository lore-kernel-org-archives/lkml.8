Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4E3C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DEC2076E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nnqJ9jmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgCTN2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:28:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53716 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgCTN2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:28:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id 25so6505751wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 06:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bbJaYLpxU8XXdc8d+5VShL8Kd/qrqFMok7iO4nMhIUA=;
        b=nnqJ9jmylnpMOjV2SiijEZbC7o669iynhXBc/AO4L1OCw1VTZErJ3AD0WHerUrBi+Z
         /s4C1ufnrubyuLM1GvaB22RhN0L0my0D4WFzrm6r2xndM5bpX6mSE5dn4AePQTn6hfmB
         svBJ8fPsL3ZenAbCcQpkTRL1kpKgAWuKsJ1gx+I2vxkzTohXkij5dZQnJb1F2BKpRixx
         6Ux11ExlA4cnx+f2WZD0TPt4RcRpua+6kicAD06u3j9LFYoIYnN+i56JNUzt6miJ/Y8C
         9I+KMUIHZuNLug63/94HmbDEXIgWrJhtlEuxAXU0NFOrgCFZqUnx+ZuvGJGHwGZLnOnd
         vWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bbJaYLpxU8XXdc8d+5VShL8Kd/qrqFMok7iO4nMhIUA=;
        b=LJTZLcKLq+9fTWPvnvYFX1IUFQ/RXB8MiboEZIO+JjmJgCOBTRfQsbpUp6UNBLX8Af
         lQ/+g5ga/k/rW6gqsz+aLMIog4ULlh4p/mtYofGXf78sebJjJT1m2l8JI41UvJ5HLeQo
         rwy+3SiNB1ymy0iiadJWAQuSOaHOzBx88Bbfmk/LEEN2FqH3Q4ugM2oarYB3XdyNAEjJ
         A14fkTQtCEuuD3Gin/APmUTjhWL8KkDz4uEIazs3Oiuj3dApIc6q4nz+5jeIoFU8RZ8J
         DU4bJjbncdl8Q3zVrl2NxuD0w7wtLigBzpDihS9Ypq4n8OgFx8A7T1vA66qHC4VSc7Fp
         rIGg==
X-Gm-Message-State: ANhLgQ1P5RXtzBXjIIssbM0ja0KSKunV7bzZ8BbNMPjFplM1paZTSjfJ
        X7xtYfqiAbThiw6K4YWzashlRQ==
X-Google-Smtp-Source: ADFU+vvMwyOeJ1bw+b6fHEvAIEyef46hTkIwvJkawUe8Y1M+n9FzyKHV88aLPaSsWHc1yabEAZvqYA==
X-Received: by 2002:a7b:c458:: with SMTP id l24mr10063577wmi.120.1584710892462;
        Fri, 20 Mar 2020 06:28:12 -0700 (PDT)
Received: from dell ([2.27.35.213])
        by smtp.gmail.com with ESMTPSA id x24sm7637493wmc.36.2020.03.20.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 06:28:11 -0700 (PDT)
Date:   Fri, 20 Mar 2020 13:28:57 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] dt-bindings: bd718x7: Yamlify and add BD71850
Message-ID: <20200320132857.GC5477@dell>
References: <20200320094233.GA30959@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200320094233.GA30959@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020, Matti Vaittinen wrote:

> Convert ROHM bd71837 and bd71847 PMIC binding text docs to yaml. Split
> the binding document to two separate documents (own documents for BD71837
> and BD71847) as they have different amount of regulators. This way we can
> better enforce the node name check for regulators. ROHM is also providing
> BD71850 - which is almost identical to BD71847 - main difference is some
> initial regulator states. The BD71850 can be driven by same driver and it
> has same buck/LDO setup as BD71847 - add it to BD71847 binding document and
> introduce compatible for it.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Mark Brown <broonie@kernel.org>
> ---
> 
> Hello Lee, Do you think you could take this in MFD? Rob and Mark have
> acked/reviewed this.
> 
> This is a resend of a resend of a resend of v2 - no changes other than rebasing.
> 
> changes since v1:
> - constrains to short and long presses.
> - reworded commit message to shorten a line exceeding 75 chars
> - added 'additionalProperties: false'
> - removed 'clock-names' from example node
> 
>  .../bindings/mfd/rohm,bd71837-pmic.txt        |  90 -------
>  .../bindings/mfd/rohm,bd71837-pmic.yaml       | 236 ++++++++++++++++++
>  .../bindings/mfd/rohm,bd71847-pmic.yaml       | 222 ++++++++++++++++
>  .../regulator/rohm,bd71837-regulator.txt      | 162 ------------
>  .../regulator/rohm,bd71837-regulator.yaml     | 103 ++++++++
>  .../regulator/rohm,bd71847-regulator.yaml     |  97 +++++++
>  6 files changed, 658 insertions(+), 252 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
