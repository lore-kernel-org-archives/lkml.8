Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C09C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB15420782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdFoMokp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHYQp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHYQp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:45:56 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB04AC061574;
        Tue, 25 Aug 2020 09:45:55 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 2so6669036ois.8;
        Tue, 25 Aug 2020 09:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AXoocnEsJlEHHnihReD4/CUqd25iKJyrxvO68JJswpY=;
        b=UdFoMokpr4QdtbVhvp+NJOxElMwfc66NbAx1KDdFzkU4xkoBmb56QHw6NgJFxnk4pk
         67619ero98YtGRFZ7LCYu8gAbd3MbZwoNxf0X8xU9G53eUwXrRttCysxTeyaP6U0bTbK
         jSukn+F6XK52/umquq9l7FJyQtkkI5CANagey23quOuoZqRFyzp54XXyrlzel9dI/fQo
         r5gu7VdD1AAbCny1n60lcf5HT2OIn/gr+ipaejvdkSreH+dpAsH95LGZ5H1LSZjTYdqN
         VoXFIcpt/ImSFYNbwQJM1afpNa2pw4Y+p01PmoTbH97jGLU6rZS3oJk/+gIChbMruxWM
         KPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AXoocnEsJlEHHnihReD4/CUqd25iKJyrxvO68JJswpY=;
        b=XyJB0ztwl5WnR+j+iGURCRjx5+Drx8foWZmy5WFWqIKthzLHzveJ1uXhLUMD0zM7uq
         VnSUJXlsS3BRq0ggLUgzCkQhZ95KmJ34Ra+VIQU61c2wTEkGyaPGWTQonb5iiCxDA5SC
         9D+PQMkXSgMftnhT2ALhe1DwTpwtKeJ3d/4+0xEAMSosRZUeXzJ5Fi25WjdLVtPYsIkE
         IaHyXqK6aJbtnhzkNdGucQcJ+rVvMufDrm+0wOv3QyNKfK/1W1OcmEzpRRz91ZSdUOO+
         VPbho85FDFN9+5xNcJ2yGgHUT93QC6efQklnhtVeMsxOj3kwlFRy0nnQM3r6ieGSxAJa
         +DwQ==
X-Gm-Message-State: AOAM530h5vxR93Hytu05Ci7CbgFxfJksDo2y1PpqxfWMaHXW4ZNl+9pz
        AFtdwgcO+6zcK2QU6XIqJRs=
X-Google-Smtp-Source: ABdhPJz7GqOyLtnB+PqSFAzoxFZkDoUw+V98PGBIGihp96GWaEbs4lolyOYDWclKQCi35YHP6PN8/Q==
X-Received: by 2002:a54:4715:: with SMTP id k21mr1313602oik.165.1598373954476;
        Tue, 25 Aug 2020 09:45:54 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([2601:282:803:7700:c847:82a7:d142:cbfb])
        by smtp.googlemail.com with ESMTPSA id m19sm2748597otj.29.2020.08.25.09.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 09:45:53 -0700 (PDT)
Subject: Re: [net-next v5 1/2] seg6: inherit DSCP of inner IPv4 packets
To:     Ahmed Abdelsalam <ahabdels@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     andrea.mayer@uniroma2.it
References: <20200825160236.1123-1-ahabdels@gmail.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <efaf3273-e147-c27e-d5b8-241930335b82@gmail.com>
Date:   Tue, 25 Aug 2020 10:45:52 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825160236.1123-1-ahabdels@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/20 10:02 AM, Ahmed Abdelsalam wrote:
> This patch allows SRv6 encapsulation to inherit the DSCP value of
> the inner IPv4 packet.
> 
> This allows forwarding packet across the SRv6 fabric based on their
> original traffic class.
> 
> The option is controlled through a sysctl (seg6_inherit_inner_ipv4_dscp).
> The sysctl has to be set to 1 to enable this feature.
> 

rather than adding another sysctl, can this be done as a SEG6_LOCAL
attribute and managed via seg6_local_lwt?

