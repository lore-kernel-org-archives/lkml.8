Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C65C2D0EE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC0F206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="EGaNa2JD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbgC3QVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:21:49 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42267 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbgC3QVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 12:21:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id s13so3543319lfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 09:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ceRQl/rDBk6AZGZV87hR1KyptG7t3Kf+Og5g8l3kQ9Y=;
        b=EGaNa2JDouvflDLK16jMocP/xa7o58nL6cBYI8lu6B771+YtUHoDF+JKGHZXWYU25f
         KemrpG/1oHZ8O9fbqwGH3f2OkmaxKyHDIcY4/YISPKDIHyUhRIwG5eiK5GmNUU2FxDSb
         FXbpCOoCuMcMKElQAFnKuh9tEqSgC3NdDhZI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ceRQl/rDBk6AZGZV87hR1KyptG7t3Kf+Og5g8l3kQ9Y=;
        b=pACFC+RCsojwBPMbZOa4/Gsn9l8ngmsZJKuGeAmw1yx1aR194w1sLQMDSLBdjEfUn2
         GjJH6b9MPIAg7fIn73vKBAHUeHVLxTzmYQqOgd51SMADiV/1oOGy+MPOLgI2MYFb//XC
         G59T/oDuTxiroFji3eJvG6treUBsxDlNAmtWHuSj7J1eXNwhXYhtudLzoVa8P1+6upLp
         14N77+dqkFI43IAg+KOg2hzZV9rul0OAYiVRAgED7E1ouseoKvVtLyC5Fs7bvKVLJyhL
         lN2+y3cpdvHmHovpFVwd5x0YVyX+P6HFAXPuKbi4m2wY5YIKEiZxz0h23ta0Zs+e9ToX
         zpNQ==
X-Gm-Message-State: AGi0PubibIAd6/w56csjr9YzSWDtBFzZJDZl+Z5xD1Zi5qVF+E3fE0W/
        KJTNBGk2knCKRkX/1nxz6IMAzA==
X-Google-Smtp-Source: APiQypKWOw8LDmb2uLPOvbKs5U0udPyVoA5MVyhQDji/LDJzya5jSfWYhT/d4nHb1hYwUh2s9frJOQ==
X-Received: by 2002:ac2:5092:: with SMTP id f18mr8506094lfm.162.1585585305086;
        Mon, 30 Mar 2020 09:21:45 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id t144sm7981885lff.94.2020.03.30.09.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 09:21:43 -0700 (PDT)
Subject: Re: [RFC net-next v4 0/9] net: bridge: mrp: Add support for Media
 Redundancy Protocol(MRP)
To:     Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net,
        jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org,
        roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch,
        UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20200327092126.15407-1-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <15dcc261-bcbb-ec67-2d8d-4208dda45b86@cumulusnetworks.com>
Date:   Mon, 30 Mar 2020 19:21:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200327092126.15407-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2020 11:21, Horatiu Vultur wrote:
> Media Redundancy Protocol is a data network protocol standardized by
> International Electrotechnical Commission as IEC 62439-2. It allows rings of
> Ethernet switches to overcome any single failure with recovery time faster than
> STP. It is primarily used in Industrial Ethernet applications.
> 
> Based on the previous RFC[1][2][3], the MRP state machine and all the timers
> were moved to userspace, except for the timers used to generate MRP Test frames.
> In this way the userspace doesn't know and should not know if the HW or the
> kernel will generate the MRP Test frames. The following changes were added to
> the bridge to support the MRP:
> - the existing netlink interface was extended with MRP support,
> - allow to detect when a MRP frame was received on a MRP ring port
> - allow MRP instance to forward/terminate MRP frames
> - generate MRP Test frames in case the HW doesn't have support for this
> 
> To be able to offload MRP support to HW, the switchdev API  was extend.
> 
> With these changes the userspace doesn't do the following because already the
> kernel/HW will do:
> - doesn't need to forward/terminate MRP frames
> - doesn't need to generate MRP Test frames
> - doesn't need to detect when the ring is open/closed.
> 
> The userspace application that is using the new netlink can be found here[4].
> 

Hi Horatiu,
One issue in general - some functions are used before they're defined (the switchdev
API integration ones) patch 4 vs 7 which doesn't make sense. Also I see that the BRIDGE_MRP is used
(ifdef) before it's added to the Kconfig which doesn't make much sense either.
I think you should rearrange the patches and maybe combine some of them.

Thanks,
 Nik

