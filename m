Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04F5C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61EDA2072F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="r9cnIsxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDIJgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:36:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39702 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgDIJgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:36:17 -0400
Received: by mail-lf1-f65.google.com with SMTP id m2so7397297lfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 02:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F1hqxHeKu6Sn0qcjBqnpzejmFgF8FiXlYOaHHEiN1U4=;
        b=r9cnIsxGH9g45TL7ekMdcxZMpShKraueO64GLT6yyMthC56S+z0hvUACligVUNToNY
         jEkYid9BTnN3B5HO4QP/VfE5DGdN0bxdrR8s4OCUvRGYmBeB2Vt7DVMO+L2S4fQs9Mlo
         /bT01v49+1apQOFowKkkbv16nQ/dExTSSHDWSJrSHVo9rPhcVwwBhycU/O84PHNyGiwb
         XChLTMm/zk9pii0YUfIMKe32XG+WA01ZozvSayP2PsvF26YcunRcCwIgRgrrVvC85tBU
         C9PfSfl5ITUvE9euSaNitly9N5M+/zfDLpQsFiaF7BQ9GM7k2/a0kwluucySEMF+2lIe
         JwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F1hqxHeKu6Sn0qcjBqnpzejmFgF8FiXlYOaHHEiN1U4=;
        b=Sh+qQ3PdB2Qb1SH+neu6Tr4Yq4ygx7AG/6e10mR3TdjOh+DbXD+wcDWLN5/9n0RBOv
         eL9Mck/C6bs12ph5VwMM1+GqqCEqDrK1XeptrBkaJfVRxngGRQtdRJE/ahQPI45r9s88
         8B2NW3sU+JAukX52fHwPnjHEySIfwvOn8cSG/SXhxjy5ANBlJwmZispC/vs40yjz8pTn
         RFsoUSBql7hvPQ6T6JbK+FngnC1e3nhdc3ScCrCNtlEfqRma7355Tg8762J6eOiU7YWq
         TnqbzJs27w9w0KgIn3zaNtp/qU0/U0j9t7IyYIs2TMstIrZiT8e3IqkQB0l5pnf8I4bX
         x19Q==
X-Gm-Message-State: AGi0Pubjx3EVKzuQU+fk8X2KgW9/Z+XOgO1prXVppyi37PNMvbTIKIk2
        g7RbXDuZOP7CYYn0t+CuhXaXzA==
X-Google-Smtp-Source: APiQypK/OqsgUggpyVaKp/qQ7mjyDy1mfGomhSAWpX/eUf3QmYwoKQnIdpStF6Miir15JkNuk554jA==
X-Received: by 2002:a05:6512:54e:: with SMTP id h14mr7301299lfl.56.1586424975925;
        Thu, 09 Apr 2020 02:36:15 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:429a:a2f1:594e:c9e:26a1:8a11? ([2a00:1fa0:429a:a2f1:594e:c9e:26a1:8a11])
        by smtp.gmail.com with ESMTPSA id 125sm14965138lfb.89.2020.04.09.02.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 02:36:15 -0700 (PDT)
Subject: Re: [PATCH v7 7/8] PCI: Add Renesas R8A774C0 device ID
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-rockchip@lists.infradead.org,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
References: <1586360280-10956-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1586360280-10956-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <e3f5fa77-f78e-edbf-9efc-53b5ea620460@cogentembedded.com>
Date:   Thu, 9 Apr 2020 12:36:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1586360280-10956-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 08.04.2020 18:37, Lad Prabhakar wrote:

> Add R8A774C0 device ID so that this can be used by
> pci_endpoint_test driver.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>   include/linux/pci_ids.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 1dfc4e1dcb94..9e957c18abeb 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2460,6 +2460,7 @@
>   #define PCI_DEVICE_ID_RENESAS_SH7763	0x0004
>   #define PCI_DEVICE_ID_RENESAS_SH7785	0x0007
>   #define PCI_DEVICE_ID_RENESAS_SH7786	0x0010
> +#define PCI_DEVICE_ID_RENESAS_R8A774C0	0x002d

    We don't add the device IDs in this file, unless used in several places.
Is it?

[...]

MBR, Sergei
