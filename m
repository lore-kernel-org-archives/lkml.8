Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434FFC35240
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 10:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D580A2071E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 10:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="jTvv0LFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgAZKEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 05:04:43 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45756 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729242AbgAZKEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 05:04:42 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so4144655lfa.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 02:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X+a0RSsX8qTothLnSZgV/VBOHW9ZL3PJUsg+L9yuDSk=;
        b=jTvv0LFLubFkhsEXfG7Qvxp6GSS+KhYZR8HMwKvhuLHZ/PzO4CnrN8ojF7QfEs72Bv
         zebHeVNuIing3pqBK30XxP9PYs3RBKe9G7k6JKQE+RmYE5xYqHqyZOmzgzPJYxLfUK+0
         WD0DeWN+o556EAkD+Q9c2siPy4LmSSJbPydtL4uJBPJQSsmL9/jmHrqMVUa4x8NO5f4a
         /HINrYJrW3gzpSEHe+MYDyWqo5cI0e3vDYRgvzvfKt9oXuX8FsaU2sDZ70mJBWoZ76jv
         cgLnzxiOa58S0GF2CPR/JGtHXxkMXV/n5B6Pko0cjRTdZsY4HXvL5dHfvg4QSf8LSTyi
         jTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X+a0RSsX8qTothLnSZgV/VBOHW9ZL3PJUsg+L9yuDSk=;
        b=kenK17kezRSR9q0QoKfCJJ2tJV0jet4phN5W9+Seu5IvGa7TW3jneqJseCTQD0BaoE
         /nM4qhgXnm6jTN+X70a42gG4/DZdaPM08/+iby/TSZUQpbJY3ekgN5W5pvzrOJRG4pa0
         TYTO5HNqrgRM3cYsGfSi61LC8S0uBo5rm4ybTRS9pygRPkRCqOlTlvjAwAJbYsp7f1Co
         AEuKNpQ1m9dwqO16h9vNcMtmR0eZguFmJReNBYQXZl/GKxsIq37YDexYqh3SKUGmgbNQ
         xqUYZ7nteX9CmIiK7w9z395ss/wlVaQ604SpLqf62VIufrLG5/7UZNVCoMwHp3y7WqLu
         hO/A==
X-Gm-Message-State: APjAAAVyfkFl0donwPY3pQ+jbm9h9aTisPrb3d3hGDqYAdwlbIwtphhH
        vrLYGouzXiE+sLHJzs2x+3oArS0F5eW78A==
X-Google-Smtp-Source: APXvYqzOMIqhu/08iu0gB1bHMAtOhBQqDBFr5YViFhfYM5qO530YULttCsWKb34V/z8S2jwjzkMMRg==
X-Received: by 2002:a19:c3c2:: with SMTP id t185mr5386491lff.56.1580033080215;
        Sun, 26 Jan 2020 02:04:40 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:6d4:c52e:d9aa:1e8e:9d86:c74a? ([2a00:1fa0:6d4:c52e:d9aa:1e8e:9d86:c74a])
        by smtp.gmail.com with ESMTPSA id u11sm6037885lfo.71.2020.01.26.02.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2020 02:04:39 -0800 (PST)
Subject: Re: [PATCH][next] iwlegacy: ensure loop counter addr does not wrap
 and cause an infinite loop
To:     Colin King <colin.king@canonical.com>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Meenakshi Venkataraman <meenakshi.venkataraman@intel.com>,
        Wey-Yi Guy <wey-yi.w.guy@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200126000954.22807-1-colin.king@canonical.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <7e76394c-cb50-e6e3-e3be-9574dcd7b5b8@cogentembedded.com>
Date:   Sun, 26 Jan 2020 13:04:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200126000954.22807-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 26.01.2020 3:09, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> The loop counter addr is a u16 where as the upper limit of the loop
> is a an int. In the unlikely event that the il->cfg->eeprom_size is
      ^^^^
    Double article? :-)

> greater than 64K then we end up with an infinite loop since addr will
> wrap around an never reach upper loop limit. Fix this by making addr
> an int.
> 
> Addresses-Coverity: ("Infinite loop")
> Fixes: be663ab67077 ("iwlwifi: split the drivers for agn and legacy devices 3945/4965")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
[...]

MBR< Sergei
