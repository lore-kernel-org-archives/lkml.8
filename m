Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12944C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14C820737
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BuCpeTuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgCZRZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:25:24 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36874 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgCZRZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:25:24 -0400
Received: by mail-pj1-f67.google.com with SMTP id o12so2684004pjs.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 10:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C0aXSSH6jnOuUiW5h4DP/qn1ilfkml9FjlWglQ0fxfY=;
        b=BuCpeTuJxIHYhgM4pr9GuJi+J095SECgRli1HbHzufUokL+dDm6MI9L2ct7BzLGsef
         oMPXccVhCwoz1uAtaANBM/UPQVu9sDWOBp/KwPpphKJi1Q7VP0HAkIPsgUDvFo8GqOOv
         a5YgVJ2b2PSwo4DPUW/CzJeEFSHF6lhmsqZPqYeODJQ0W9x5OgqOkVW4Ls8xlv92asFM
         6v5W3KjvceL15B5biEq7kfxv//LzRrI0svHbskXkxKjXxVOFfehm5mWH4Di7p/AQ9/RI
         c4BSjcJVhYP7TZAPcRkEa2EsF9RT6N5aq3FfFngWenTLPBiQLHkdtQ/thAsc1g//9/zb
         fREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C0aXSSH6jnOuUiW5h4DP/qn1ilfkml9FjlWglQ0fxfY=;
        b=PTw4KJIn0n5862Cs7yq/8DSbxaUP+NckoGs1A17uW/6ptFa1wBwy7NVlzKv29ePIUY
         u3cRwvwFh1FJvC1RODKpYM4FbUWSa0968VbHQA6t4fjBdPEORQWR9JK/8eQHlXCUdAfW
         Ob3Z4DZhj2VyBayPQjhkXpRxLFWzPD7L9bc2xakygJx4MPwMXZ/6CCpXvBXlaj1Kbrzr
         P+SZvH4oZ8GUI5d04AnSS2tM/a4m7jnN9+mCBhTMql94fN/B3j5Ig6Gy1ed2Y9Tkcexp
         bfDhIuVpY4mu64kBtlpE0UGA025DFIEwvVDiV1rYrPeGcgdznsj4oIeA+sRFzrjT+AA5
         zxAA==
X-Gm-Message-State: ANhLgQ1xD7Y0xyEAYOX+03PLxic3S7g+oqqRXFaTOQm1r2mk8I4LYobz
        HmM4toKYYVrtthSmX7VeLgMTGjKziA==
X-Google-Smtp-Source: ADFU+vseVdsHmsCD+UdMKpGktH3crnbZk2+DYLHURuVVukZble7QaNRJjwqQF55+XnCJWXdc2ZXDHg==
X-Received: by 2002:a17:90a:ab0a:: with SMTP id m10mr1054838pjq.173.1585243522867;
        Thu, 26 Mar 2020 10:25:22 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:518:654f:ac72:3cc0:da67:5ad7])
        by smtp.gmail.com with ESMTPSA id z7sm2129001pfz.24.2020.03.26.10.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Mar 2020 10:25:21 -0700 (PDT)
Date:   Thu, 26 Mar 2020 22:55:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     davem@davemloft.net, smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Improvements to MHI Bus
Message-ID: <20200326172514.GA8813@Mani-XPS-13-9360>
References: <20200324061050.14845-1-manivannan.sadhasivam@linaro.org>
 <20200326145144.GA1484574@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326145144.GA1484574@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 03:51:44PM +0100, Greg KH wrote:
> On Tue, Mar 24, 2020 at 11:40:43AM +0530, Manivannan Sadhasivam wrote:
> > Hi Greg,
> > 
> > Here is the patchset for improving the MHI bus support. One of the patch
> > is suggested by you for adding the driver owner field and rest are additional
> > improvements and some fixes.
> 
> I've taken the first 4 of these now, thanks.
> 

Thanks Greg! For the future patches after v5.7, how do you want to pick them?
I assume that you'll be the person picking all "bus" related patches, then
do you want me to CC you for all patches or just send them as a pull request
finally?

Thanks,
Mani

> greg k-h
