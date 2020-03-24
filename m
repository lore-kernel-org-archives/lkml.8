Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFCEC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 05:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B448E20663
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 05:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ljrX+nzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgCXFeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 01:34:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36654 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgCXFeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 01:34:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id j29so1584562pgl.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 22:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/TSTUAS7pvP0ZmRkI5IZvXuFAdhabZBDiE+44x81ou8=;
        b=ljrX+nzB2f3s76SBq9xehg+/86QsQkGMnIcSoYGsEbZa7O8l06KpvQs/FF5BMctmtL
         mrEflGYwhfaLEK3EDeOTjWAMQWrjqfh9NPYq9yON4sVXTWqXM+Iceg9/797A0I5e89qT
         mnPRpe0yvfHOvR7jQlWZBuB7+wAqCW8DOvXj2Z4nk2/xvQTNB6kNQ6ko9cQEQbtbQ6JF
         oPMlyINi0QmmPZOMAea/auJ8fCBCTrPSjJ5ZePOaGazbmA5Ozs+UM65slt/JhpEIHzwD
         j7D1qK1VSW2wg2UoQnUia+vKzkiVgcDDSFlIBUQrIji8z77ynhThUyhFshMMLf+AzDOY
         sIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/TSTUAS7pvP0ZmRkI5IZvXuFAdhabZBDiE+44x81ou8=;
        b=Eqn3Am/gdrYs91sN0KBWD07rv3L8j06AYdRHc8aodDgsm5minUr5EgneMjT1TDho+X
         Y4kiT9tefAXnC7P0CphwiXopwrwP0YhcAm3GTiA+wG7GTRU++C6u4eV9Sm52StDUFZME
         JOfK2fwxngQg9FdSoulkRRHzXoxibcar+kSqT1Umy6ZhdTH0ucTacWUy9NcDwVbLaRGd
         /vrDkH4ghBT7TGGZlxwlMyCkgLMU1WMbEHk2jOqre+Bf/wJ5xwaTeGlncKLDbAHzXvuN
         dvucjtNs/dUfYLmFOTyAXO9o5Eag+Z+tYYsyFnX9XC+18+Prs46/YkeRhsUXdionHqDn
         NByw==
X-Gm-Message-State: ANhLgQ0pzIbJ4Pi2D8TACW01/sPRHxkGFz5Y7AeqT8DCV2vcuYn0As/U
        Eq0wFSXY9hsOJRd354QPGk58
X-Google-Smtp-Source: ADFU+vvV0RUr88miCiQV1V7USfVHQnRUiV1da952qkZQH9yh+rNWjmRGD4aM1dM2OiD4dtIoOuuDfQ==
X-Received: by 2002:a62:e107:: with SMTP id q7mr11066372pfh.190.1585028047098;
        Mon, 23 Mar 2020 22:34:07 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:59b:91e:2dd6:dffe:3569:b473])
        by smtp.gmail.com with ESMTPSA id z12sm16163241pfj.144.2020.03.23.22.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 22:34:06 -0700 (PDT)
Date:   Tue, 24 Mar 2020 11:03:58 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, davem@davemloft.net,
        smohanad@codeaurora.org, jhugo@codeaurora.org,
        bjorn.andersson@linaro.org, hemantk@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 7/7] net: qrtr: Do not depend on ARCH_QCOM
Message-ID: <20200324053358.GA11834@Mani-XPS-13-9360>
References: <20200323123102.13992-1-manivannan.sadhasivam@linaro.org>
 <20200323123102.13992-8-manivannan.sadhasivam@linaro.org>
 <87lfnravao.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfnravao.fsf@kamboji.qca.qualcomm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 06:30:07PM +0200, Kalle Valo wrote:
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
> 
> > IPC Router protocol is also used by external modems for exchanging the QMI
> > messages. Hence, it doesn't always depend on Qualcomm platforms. One such
> > instance is the QCA6390 modem connected to x86 machine.
> 
> QCA6390 is not a modem, it's a Wi-Fi 6 (802.11ax) device :)
> 

Ah, yes ;) Will fix it in next revision.

Thanks,
Mani

> -- 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
