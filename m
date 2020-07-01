Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C592C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E383820722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPMgxzjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgGAJcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgGAJcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:32:00 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4BDC061755;
        Wed,  1 Jul 2020 02:31:59 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id o4so13198257lfi.7;
        Wed, 01 Jul 2020 02:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+d2SRZpUuZWr1PMsXvidGGiJQELrujV0Qtt40StTl9g=;
        b=LPMgxzjfikH+ekjnDGlTo5HiuTopob0mrOhZ1T/TKzKtXLxS0g4zBNmRe4QQhLRWCL
         1okLKn+Jds1VZfA9DHmyLb+y/xGtwpQBIO1ZdlkPvO9N8WeoZMnfxvq3clumZ9GHv0Q0
         aFO8jZ+cnyzkNl2SohOvL8XiWK5dCOphinB6XKDqGxlAIn1M7x7e6vHghvsHVFjsPAQL
         b8SqBPJiyUBnXFq4723+bDoYT32KRtFpH3swa+46WMWAEGUMygpGz0oJc09WUQJzfhKr
         QnIXNL234ZMfeU4c+si47EQIseg4quCNPhwJ/zonjU15pu7rYi1rD+0yIPDR+3rxechB
         6/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+d2SRZpUuZWr1PMsXvidGGiJQELrujV0Qtt40StTl9g=;
        b=dIcz8fF2JOTOS/t12dA+6VaXxZcoIsRX7ie4TOVxHBgOaLrnKGYB8zIMYMO39iZ6QR
         fR2EYN7Fr3W+Ww090C0LrPHHHxF7vHAsmqFk3h6/wDylrmWGf0Bz9GlIhIrOio/BrR73
         zuzfnzXzRiCyczDAXOISOHkLuNZ65NJKEpBC4xNdwX4EYHWZ9xVk+gDzqznhrLes3L59
         C0gqBtSEbzP0uKlN4dyHhkqYhbcn1CjbJQcxa+KxnLhtR/TWWlDjfR9vi94mUfXYpBvR
         IBhRZizCdbdGAcc4UTSIgdn+CsTjLxtHk1AaMcOql8ZnA8q3J83nBkXthn5ICbtsvX2P
         Av9A==
X-Gm-Message-State: AOAM530NkUFwr+bClU12xiyv8T3Ovzolv9NUdh3VaAQC9K6I4beDcgwp
        h5tLo2JEPmxvQQD+CldbTc/iZeFjS9A=
X-Google-Smtp-Source: ABdhPJwN/668XQNGZmBOPiKhnbVfqe8RSFARvz44SINyM2X+GeJXU84pm9ni1lENZx3wdjXS8lutaw==
X-Received: by 2002:a05:6512:49d:: with SMTP id v29mr14700624lfq.134.1593595918072;
        Wed, 01 Jul 2020 02:31:58 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id m11sm1621386ljj.122.2020.07.01.02.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 02:31:57 -0700 (PDT)
Subject: Re: [PATCH v10 0/2] Silence missing-graph error for DRM bridges
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200701074232.13632-1-digetx@gmail.com>
 <20200701090240.GA22218@ravnborg.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f4d50b9f-06e8-b6f7-ea5c-7a71f27ae953@gmail.com>
Date:   Wed, 1 Jul 2020 12:31:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200701090240.GA22218@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.07.2020 12:02, Sam Ravnborg пишет:
> Hi Dmitry
> On Wed, Jul 01, 2020 at 10:42:30AM +0300, Dmitry Osipenko wrote:
>> Hi!
>>
>> This small series improves DRM bridges code by silencing a noisy error
>> coming from of-graph code for the device-trees that are missing a
>> display bridge graph.
>>
>>   graph: no port node found in ...
>>
>> One example where this error happens is an older bridge-less DTB used
>> in conjunction with a newer kernel which has a display controller driver
>> that supports DRM bridges.
>>
>> Changelog:
>>
>> v10:- Corrected doc-comment, unbroke the of_graph_get_next_endpoint() and
>>       improved commit's message in the "add of_graph_is_present()" patch.
>>       Thanks to Laurent Pinchart for spotting the problems!
>>
>> v9: - These two patches are factored out from [1] in order to ease applying
>>       of the patches.
>>
>>     - The of_graph_presents() is renamed to of_graph_is_present() like it
>>       was requested by Rob Herring in the review comment to [1].
>>
>>     - Added Rob's r-b.
>>
>>     [1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=184102
>>
>> Dmitry Osipenko (2):
>>   of_graph: add of_graph_is_present()
>>   drm/of: Make drm_of_find_panel_or_bridge() to check graph's presence
> 
> Thanks for your patience with these - applied to drm-misc-next now.

Thanks to you and Laurent!
