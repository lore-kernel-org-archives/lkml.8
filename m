Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A9CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B921E20732
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="esoOeJ8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgCEO65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:58:57 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:43433 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgCEO64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:58:56 -0500
Received: by mail-il1-f195.google.com with SMTP id o18so5250445ilg.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 06:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4bV4e2J0Fj77NrhTqn4U15G8AA1APxJOoLr6qnKhOMc=;
        b=esoOeJ8vk39jzQbYXfJq1SFqiVch6RalQvjHVWANNM+olC7WkFv8UUMuQ4k+3AeujU
         ldsf+SXtvo2g8fplfXNBTqV+HxFYw6ytavS9Yi7rvCgn997XMPTs3uiEzZjmgelDYMCA
         xNyZd/mKHxBuLL6JVZzGh0lwA3OO4C0t8vi2Pt+RiDN9vgxbT+NiW1IRO5iE9ITrZ2w3
         UP+RFRkwFWKqt51wrEKEBUiHwdgDyL+BIAkI+DrfdBZ+kU6HSCM1xHd8nnrR+rguCUE5
         lW+cVrCGK3+K8UgQ9iuIpsdovS8ZDK3sNetDv3lVs7x9KFBjvTXoLDXZhTOxKkb3wbQR
         PWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4bV4e2J0Fj77NrhTqn4U15G8AA1APxJOoLr6qnKhOMc=;
        b=dFQMFS8KSA61TDokFWzvENNKexyJNjWdIYeCJnry3IYbLpvY6OUcXh1yFaIoI+4Rax
         D1/MXke8LS/gn4LFfRlD9+jk6boaFvpizJgJty9G7Z4Rqtp5ZWyIA9dnxD3/AkE+Tdng
         BZHGpcvCswBsyaFckUKDXyJmZ9YWSzedTWtSWYZwiTki3wJkb/o4iTmyzLcQ8Y9P+flg
         0DVPNZAJ+CdewwcqWcRoFAtbVDuiow8cyYf81wAk8230wfbaHK1QTfCFnUsrnfMF7DAK
         cQM/YE3uu/Q2DHiPCN1lCDgkqcuXLzBWcDGBU141m3WF3u0tDdQ1632GX4Zqo6aO8W1B
         OB5Q==
X-Gm-Message-State: ANhLgQ1vS904tskQbkjAQDmlORDuGk50Xet1I4SOG2GLmfM6QuHQWtsQ
        FHKLop7L1JZAUcbFt6E66ph7bIX5dPk=
X-Google-Smtp-Source: ADFU+vtpeY9CxlaepFzd4eHxFzmg0UDavlbEE426APDD8aZtC+Rwtl+OAoe0AHeKrotvehazhLMiPw==
X-Received: by 2002:a92:981b:: with SMTP id l27mr8649435ili.118.1583420334176;
        Thu, 05 Mar 2020 06:58:54 -0800 (PST)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id p78sm6860932ilk.76.2020.03.05.06.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 06:58:53 -0800 (PST)
Subject: Re: [PATCH 00/17] net: introduce Qualcomm IPA driver (UPDATED)
To:     David Miller <davem@davemloft.net>
Cc:     arnd@arndb.de, bjorn.andersson@linaro.org, agross@kernel.org,
        johannes@sipsolutions.net, dcbw@redhat.com, evgreen@google.com,
        ejcaruso@google.com, syadagir@codeaurora.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        robh+dt@kernel.org, mark.rutland@arm.com, ohad@wizery.com,
        sidgup@codeaurora.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200228224204.17746-1-elder@linaro.org>
 <20200304.141547.1905642444413562833.davem@davemloft.net>
From:   Alex Elder <elder@linaro.org>
Message-ID: <d422e872-ed97-76a0-e8d8-457e8932f4ff@linaro.org>
Date:   Thu, 5 Mar 2020 08:58:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304.141547.1905642444413562833.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/20 4:15 PM, David Miller wrote:
> From: Alex Elder <elder@linaro.org>
> Date: Fri, 28 Feb 2020 16:41:47 -0600
> 
>> This series presents the driver for the Qualcomm IP Accelerator (IPA).
> 
> This doesn't apply cleanly to the net-next tree if that's where you want
> this applied, can you respin?

Yes I will do that today.  Thanks.	-Alex

> 
> Thanks.
> 

