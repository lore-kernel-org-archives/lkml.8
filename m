Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBA5C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 01:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2FF2465A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 01:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579744538;
	bh=RbMeBKw6SHGsAD24xdJyFeDAwg45Ig27yfo/NYLITiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K74UZsCVXIptwgVNigKvcSPTkbxb1Kp9m/wn8J7gQY7346p6l+NiX3kxUVyJ9hrVi
	 Q37zC6Fj+zw1Ao0RAOIkQA4f5lX4hnQvtuNEQCJDWuX3tAaS5LF/JHZFHKqZvlogVS
	 ZfyD5gR6869gBSozqn54j+I6kuS3+oO6wX958XUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgAWBzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 20:55:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46891 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWBzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 20:55:37 -0500
Received: by mail-pf1-f194.google.com with SMTP id n9so724992pff.13;
        Wed, 22 Jan 2020 17:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U/9QhT+ohC+FY6Xzfn/y36apKCPCrHk4ZLflzz5fU6g=;
        b=HmKrq9i6UTQOujYHxMVVJYgTRi6w4yV+PyHGcUoOS7jQK6CytW68axj7QswFIAkroR
         zoaMZwfnrqQMU+dh9NSyUqiYyJ9ZZWqXpOJi2NsboW6vwJvvRHkK7eiCVRckGu4XFfmS
         iZrnh8uqhdjhF2CB033YnECFXskRt6RvWpfNSc5UYss0CA0QfH6iIzg5RqhkYEKZu1d7
         N5ASFJhpncfwIHN2FwlnCqOjw9VBs+bGS54E5NkflWfwem/mQRvb94R14kZmL1e22i0O
         HBkO6DDiSBVlXxR/PZx6u4WPSBCVvMya4o33zV9AuC+BzXZ1S2TU8IpKd2M2qAZ84GQi
         N1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=U/9QhT+ohC+FY6Xzfn/y36apKCPCrHk4ZLflzz5fU6g=;
        b=k7+HlTYIc+Fe25Vs6wYTdU/92qndIo7h9of4426EaLEAi2U+mlPVc8aTJcY1te5c7u
         mm3pNIRU09+OJdp3FpXHrQDscC7IHGdaCun5D8eTxP78GjlNI6KbHJ2MY9kjcLXSnD75
         DqkcISvpB+kr9IWMMYM4+wYVNnNtEpzPwPHNHBSC7NQ1mNigsLtdM8TLv8sb9OaaQtyB
         OaQ6TS3aoi2JIcFPRg/rMsGyIVtvFrvvLwHetHn8iIsNpUnIBSIfYn61Ot0yi+RnvEe0
         dCD0v8pWKRkGJgH31ctKzTJf3NRQh48gouoPNsfigtA49d/ZbV2NqQXDbiHQKMjSBL1l
         ebtw==
X-Gm-Message-State: APjAAAV1dD8uqC4xPfpnS3FpvySherPzxwB5dYiET9vKoWasAMnfXqnL
        GcurHvYkkOowdlmhXLHNSkk=
X-Google-Smtp-Source: APXvYqwcPZDd3TH6DQcYJCQhKz5YbG9/pomqV4qommUPmX8pUCo2zNoIadM1hsstxeuv5JojCVCLoQ==
X-Received: by 2002:a63:4c4f:: with SMTP id m15mr1322140pgl.346.1579744537053;
        Wed, 22 Jan 2020 17:55:37 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id w5sm237103pjt.32.2020.01.22.17.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 17:55:36 -0800 (PST)
Date:   Wed, 22 Jan 2020 17:55:34 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, huyue2@yulong.com, zhangwen@yulong.com
Subject: Re: [PATCH] zram: correct documentation about sysfs node of huge
 page writeback
Message-ID: <20200123015534.GE249784@google.com>
References: <20200120102949.12132-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120102949.12132-1-zbestahu@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 06:29:49PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> sysfs node for huge page writeback is writeback rather than write.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
Acked-by: Minchan Kim <minchan@kernel.org>
