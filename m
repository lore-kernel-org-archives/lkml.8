Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647DFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 06:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C26C20772
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 06:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SrgeLd87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHQGL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 02:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgHQGL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 02:11:28 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE13DC061388
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 23:11:28 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f10so6978332plj.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 23:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cb3gD5Ol5PjxsLyVhS0SzWYOAS+ci8gm0+f1gP19RNs=;
        b=SrgeLd87+/gbsG125lzBXZzQktP7CnLnf1KrrgvSuShBi4d7qE8OGJBnwxRFfUn+Gn
         3VK3P1AnKzlxP6WKDA2L1UrRrc3CBVFdCiJfpdu1C8th15AuDpdupVimpJwLB5VVK0p8
         fYsWfaqVF85IC0yiKJycBJG/X0+MBkcjSCyPaoySZp+sO2EUHy4BZiZFG5dozp5VAPT9
         F20gKw9yKOE/pD+sabWqxJcrWWj6jjtmEQNJKpCt0Xl+MGgliB844FE4Z/HEWlSbrnr3
         GSAa33sr5JcTzQZKuiINu7HCHtNIb0+UfMeKepIRwifdXawY8EgA9P576DjtsDjn93Ed
         8S5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cb3gD5Ol5PjxsLyVhS0SzWYOAS+ci8gm0+f1gP19RNs=;
        b=JuEgJ7llnRJx0r+C6qAmZP+mab2OFak21ekvdEh9UDh9WCa+AE78sge+PRl8yPciJ3
         c0sAuX8uS/B8UfImm8PQ/iCUWwdwcKtBXgSJ0+YYVDwQl0zPxpxnJnP9QX11CUKjpgBi
         nDx2esyMUacxyCRFbTQS3yXUEhuR8f+J6jIUe7DRHudU+YfPi2mhr76yEZTeSMWW1kvg
         cKEqR/W5zZ/d4uO+u3k5GLN5Jl76uZeO4voqyj+5lpoUM+y2JbLQ5BChD60v/RW3ARE2
         RRnvV3C21CwVNbEBJX/1x4Xj4pEp5h3Aj5AzS8v3C8XYeIW4vc7z1kZGkB+YxQSJk2R8
         rvuw==
X-Gm-Message-State: AOAM533rPgtT7fT61fC4btT7RhTEzXD98v2UCKmX5lCShIz/dAApR+vb
        nWyyNOFq+euFHeEw5I3KVqqEkQ==
X-Google-Smtp-Source: ABdhPJziMxdOUKQ0wZ76PzlysVihxePmv+yybPL6fpEpTS5n/S1cZoi0d8ioHxFCmEl70SBMlSPV4g==
X-Received: by 2002:a17:902:8a93:: with SMTP id p19mr10133871plo.320.1597644687979;
        Sun, 16 Aug 2020 23:11:27 -0700 (PDT)
Received: from localhost ([27.56.169.149])
        by smtp.gmail.com with ESMTPSA id i7sm16032286pgh.58.2020.08.16.23.11.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Aug 2020 23:11:27 -0700 (PDT)
Date:   Mon, 17 Aug 2020 11:41:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [greybus-dev] [PATCH] drivers/greybus: Use kobj_to_dev() instead
Message-ID: <20200817061123.7mpmstteqxliv6n7@vireshk-mac-ubuntu>
References: <1597289690-22857-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597289690-22857-1-git-send-email-wangqing@vivo.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-08-20, 11:34, Wang Qing wrote:
> Use kobj_to_dev() instead of container_of()
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/greybus/interface.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
