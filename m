Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F74C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D00CB20775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Ha5axPlY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgFZGHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:07:18 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:54383 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725801AbgFZGHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 02:07:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593151636; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=kpNpS5FXksDhKX01QPjtTgzG0vgpwu5AuVAt8JX2QKM=;
 b=Ha5axPlYMft9PAifW/fBBVOYKM6za1UmKcgSnDHindRiWxiwY/h8PGEXQ5TZB+XWnx7p5GAX
 hfIxumUr0JgnpZGAnvlQCSE0fAjdS4A47hKh1u5vXwyHB4e2oeRdpUqrVRCrApHJQ6ThWiz4
 N3xxhOvA/v3uhuook1WCBQRKZBk=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-east-1.postgun.com with SMTP id
 5ef590890206ad41d1ec1724 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Jun 2020 06:07:05
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0233FC43395; Fri, 26 Jun 2020 06:07:05 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D55DAC433C8;
        Fri, 26 Jun 2020 06:07:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Jun 2020 11:37:03 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCHv3 0/2] Convert QCOM watchdog timer bindings to YAML
In-Reply-To: <20200625211809.GA175066@roeck-us.net>
References: <cover.1581459151.git.saiprakash.ranjan@codeaurora.org>
 <c2b8fabcf82b27c7334482bd53ebba62@codeaurora.org>
 <20200621073320.GI128451@builder.lan>
 <ce4c2b44cb15af12b04c09f1786a6c1a@codeaurora.org>
 <20200625160042.GC149301@roeck-us.net>
 <3e3cf81452e33c9385900177d0630a11@codeaurora.org>
 <20200625211809.GA175066@roeck-us.net>
Message-ID: <055b46ca29e4d54981116f2a55ed0b77@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-26 02:48, Guenter Roeck wrote:
> On Fri, Jun 26, 2020 at 12:52:31AM +0530, Sai Prakash Ranjan wrote:
>> > >
>> > I don't think the watchdog mailing list has been copied on this series,
>> > meaning I don't have a copy that I could apply if I wanted to.
>> 
>> I kept you in CC for all the revisions but missed adding watchdog 
>> list.
>> Will resend with the appropriate lists added.
>> 
> 
> I use patchwork to track patches, tags, and my responses. No patchwork,
> no patch, no tags, and no tracking.
> 

Now resent with watchdog list added - 
https://lore.kernel.org/patchwork/cover/1263944/

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
