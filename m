Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92046C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 05:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6316D206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 05:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tc6nFv9M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgCCFpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 00:45:53 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:38746 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCCFpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 00:45:53 -0500
Received: by mail-pg1-f179.google.com with SMTP id x7so994385pgh.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 21:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wnuce1BEMaLV9odhtqcw36E1SWjthugxOUocptLg1eU=;
        b=tc6nFv9M1NJtZB1NZhMnMMn6js7Ufn+yAAM+nS75545HYTHHzMPWGwB+kN2uLa1y2j
         OS3lxooIOHPQRvcMKNTWdlCJzpZJOVZJfVXXJQ5jf4D99Jb5BxdUL2ZTnsUa2Ozqhm5B
         ypujDRL2Xo4QOYZdT8VqjznTd4gVeuj3f25IxpLMeKJKzy86YKYyHW4I4CLfTvbHS2L+
         EeCvqRAyLVj+GCeE3Zz6GRqojyzCP8llrgoppm0080Mb6QV7/xU2PjO0APxo9Z9ZzN0c
         BCXflIKd2wGxlOuTH+TRsmWSR3Gi5kZaCo44SDUX2B1awqkBIxoFxhN+LAd+nd42zwQO
         595A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wnuce1BEMaLV9odhtqcw36E1SWjthugxOUocptLg1eU=;
        b=lKlbD1bC946ED1uuy0cVts/4Jo5NaILBcVKEOjUBg1hiEADaEC8ccQfp7L3ARKFg5m
         d9awZ2q+wYyiW4Frj3M1H8axD01YkHlcVCJ/Sm5pEuuN2vX+9YGLIbAIqaneXivKlYBu
         QQkTGoR6ajcSLAglmMtaqX9Vjv8dURaRvEOECqi+vP3KaSYzr2cT1eplTMokX2ovbFc5
         QE/3iEUa3Arc0+HuNqL+FA75WK9C/gJ4GmZJOxmI7zSYot0SBWvK4/L1XajUbIi+IJaG
         FbqrD7d6ClenijMwC4VsLlZ+SCLwpEDP0hR5OYstcAUa3RsgQMDk+l/K+G7s895C9Lun
         eRNQ==
X-Gm-Message-State: ANhLgQ1ZftuN0DL9dLTI+39k7hgjizzOUo3Y6dIt92HTv+Bqs1iVd+sV
        nkerP5mGMuk5Pt+oR1XtR9U3SQ==
X-Google-Smtp-Source: ADFU+vtlUTCjeL46Zb2JwQRGCfBgPlvipN94mw2Bm1lTmvsdnScdE/DSOFjY1YTYg9ynNjhLyHpAfw==
X-Received: by 2002:a63:cd16:: with SMTP id i22mr2517574pgg.79.1583214350354;
        Mon, 02 Mar 2020 21:45:50 -0800 (PST)
Received: from localhost ([122.167.24.230])
        by smtp.gmail.com with ESMTPSA id m16sm22664861pfh.60.2020.03.02.21.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 21:45:49 -0800 (PST)
Date:   Tue, 3 Mar 2020 11:15:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     peng.fan@nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] Convert i.MX6Q cpufreq to use nvmem API
Message-ID: <20200303054547.4wpnzmgnuo7jd2qa@vireshk-i7>
References: <1583201690-16068-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583201690-16068-1-git-send-email-peng.fan@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-03-20, 10:14, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use nvmem API is better compared with direclty accessing OCOTP registers.
> nvmem could handle OCOTP clk, defer probe.
> 
> Patch 1/3 is dts changes to add nvmem related properties
> Patch 2/3 is a bug fix
> Patch 3/3 is convert to nvmem API

Should I apply patch 2 and 3 ? And you can take 1/3 via ARM Soc tree
as this shouldn't break anything.

-- 
viresh
