Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A73C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0578A20724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zy7A3gLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgCSKJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:09:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54115 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgCSKJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:09:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id 25so1397715wmk.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 03:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RUn9UxzNYqDlVvjBdc02JsbNjG/1HKK11KHzgN8DpHk=;
        b=Zy7A3gLvgvG/ej7PLOBuw+h4UHQ5YbbbobNUkbeATbvkfuxaQMOb0vCCzKzXulEcjw
         Bflohb+c02EaGzLqe2kK0BuFaN6SiD4Vh3o5Z5DsCwi/hTTnjafJiooBLOzlmiLonQfq
         VErW8XaIC6T6pTsNu7/AX+kP031rgbcXZ6HgannJPJPKd2wqBCXPu006yPFmo21RUGiN
         L+Uzh/7ygSs1dOedYs1gEKqoqeQMW7ydWG1eRuOmfe3pM3dwE2yYYcQzmxvI3QcPe2f3
         XzwNrVNlGh2T8ZCEksGYeFItDSMGoRFJuF3kAKSgBT79fR1850m+Cy0qSAYAGwYgneQl
         Pkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RUn9UxzNYqDlVvjBdc02JsbNjG/1HKK11KHzgN8DpHk=;
        b=bCVtoLu1+9T+qomcNAc/K+ZGztv9eX9eYIEZjB1iH3d+Jby/yH+7FdJ00wF/W1AaZi
         6BcpzcdQJnjFkJ65/17MGKo7mAGRch9mFV4yCP+y1/dkULom8udLzoi3rHgMto05kfiB
         aialQRTMG0WJIIDLkbFy3+GYnPOek9agzw2xCxS+s3HP3OjEsBDRVuuTgml01TIjbECE
         +3BY1YeDUCy38LQh2BEb10cCxhRm0ZWzAenv0mMFEFBwbyASIVpKTagf5PDckb1nVu1/
         7KOkM4XbIU2ycDoBzKe6u2Te5oGsRbGkAOqTYwB4Wp8YM7GR44AXF37yk3Fhctb1Ugm0
         0omA==
X-Gm-Message-State: ANhLgQ3gK+eC6cjWbZm/5DpOfYBhEUEoeWjzMGqm1wed2xUFcdZQJIlf
        6IC1cZFtQACZS6txmYNQ0mTF+Q==
X-Google-Smtp-Source: ADFU+vvPWW5ImdZ2pav4UsRH9+6PgZUguig9OJgjiIdwzr6ph+GkNIPoA4BMw5D7ED82x6qxdypSqw==
X-Received: by 2002:a05:600c:2319:: with SMTP id 25mr2829698wmo.106.1584612568933;
        Thu, 19 Mar 2020 03:09:28 -0700 (PDT)
Received: from dell ([2.27.35.213])
        by smtp.gmail.com with ESMTPSA id h16sm2730355wrr.48.2020.03.19.03.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 03:09:28 -0700 (PDT)
Date:   Thu, 19 Mar 2020 10:10:14 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, tglx@linutronix.de,
        fabrice.gasnier@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] mfd: stm32: Add defines to be used for clkevent
 purpose
Message-ID: <20200319101014.GA5477@dell>
References: <20200217134546.14562-1-benjamin.gaignard@st.com>
 <20200217134546.14562-3-benjamin.gaignard@st.com>
 <e9f7eaac-5b61-1662-2ae1-924d126e6a97@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9f7eaac-5b61-1662-2ae1-924d126e6a97@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020, Daniel Lezcano wrote:
> On 17/02/2020 14:45, Benjamin Gaignard wrote:
> > Add defines to be able to enable/clear irq and configure one shot mode.
> > 
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> 
> Are you fine if I pick this patch with the series?

Nothing heard from you since I Acked this.

Are you still planning on taking this patch?

If so, can you also take patch 1 please?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
