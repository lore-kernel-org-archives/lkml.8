Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DC5C35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09E52073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="TO6LxZ9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgBUNQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:16:09 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:22183 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728228AbgBUNQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:16:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582290968; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=oTA36HHmGmniDobecPjLQVGncMTLqDHJo119ZiOygsk=;
 b=TO6LxZ9G5LVNlOzVCV+64ns0DwDCuBRXIkb6BKnQ3VJiA1AbkGTeyvb05QmnOh3KB0XZPj4r
 /G8joV+nxwRGw5T7gH0DjVolt4IjKun+jeaDku5ZrKECV4cO4k/dkSs5g+F6Xn33bLr1T/4S
 zvyGA6751zfTDa/7c9bH8DGN1G8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4fd808.7eff649a8b20-smtp-out-n02;
 Fri, 21 Feb 2020 13:15:52 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B6752C4479D; Fri, 21 Feb 2020 13:15:51 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C02FC43383;
        Fri, 21 Feb 2020 13:15:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 21 Feb 2020 18:45:51 +0530
From:   bgodavar@codeaurora.org
List-Id: <linux-firmware.lore.kernel.org>
To:     linux-firmware@kernel.org, jwboyer@kernel.org
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, gubbaven@codeaurora.org
Subject: Re: Firmware files for QCA BT chip WCN3991.
In-Reply-To: <3d3a530f11e6bc9a87573389d72ddd3c@codeaurora.org>
References: <3d3a530f11e6bc9a87573389d72ddd3c@codeaurora.org>
Message-ID: <b69f21863b936c2407d2e22dcd258013@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Josh boyer to pick the firmware

On 2020-02-20 16:05, bgodavar@codeaurora.org wrote:
> Hi,
> 
> The following changes since commit 
> 54b017d06a44bfd9b4c2757cace6cc349afd5bf2:
> 
>   qca: Add firmware files for BT chip wcn3991. (2020-02-20 16:01:04 
> +0530)
> 
> are available in the Git repository at:
> 
>   https://github.com/bgodavar/qca_bt_wcn3991.git
> 
> for you to fetch changes up to 
> 54b017d06a44bfd9b4c2757cace6cc349afd5bf2:
> 
>   qca: Add firmware files for BT chip wcn3991. (2020-02-20 16:01:04 
> +0530)
> 
> 
> Regards
> Balakrishna
