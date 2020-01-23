Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0521C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9F421D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579808659;
	bh=uPKlTObgZo0j0KupJCzDGJAPw//Q9QP5tH0jq2JvnjM=;
	h=Date:From:To:CC:CC:CC:Subject:References:In-Reply-To:List-ID:
	 From;
	b=AzoTrVfb28ZpPFSMAeC4uFnX5OXlp9hk7BhWztTPW6xbDAIXl/LWtXXMaMIq72H8B
	 +PDdkIk07iRtDb+VzdAwWQDC680OFbAAI2YgXICJUoFwJQMsynY3d+CZNsaE9a1uDw
	 0hX6d+NlQwot+wZMF+pbeAojncvlJ5yOyrM66vqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgAWToS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:44:18 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43207 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbgAWToS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:44:18 -0500
Received: by mail-pg1-f195.google.com with SMTP id u131so1876068pgc.10;
        Thu, 23 Jan 2020 11:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:cc:cc:subject
         :references:in-reply-to;
        bh=eDdBKu4+lIbnXRrbYvUijk45X2JfgQi+0fmWjhCNciE=;
        b=PMoKyVy7g/uBp5oHirLHYod0UUh/g2O8Ir9ChCPVDCSksNWgrLAnoiP3d7cDr9hzTQ
         UA3A6rn3ku3v/7gw2Om3eARoPOCVtp17vuGi+P683L/Zbw9vHdVigW1SipDA2oisX/6n
         ByDjHbOmIL4TCKZ3boiRFDF3iHimHexdwqbyLSif+791XkHofnqOgMmKG/57Lw8W5nis
         rK0Pd9NM4DALYQI3fOQt07yc7rzhhfaX/xhCRJJ0KaOSV+gkZvu+mEhPgpNpR7Bv3+XA
         4uzVQ+VZ8chqzYG5Ei0ck0jRAbbgbjOhzgFkVwdmF8xHe1MWkFcHOGuP4dUd3fPZaoOY
         xtKg==
X-Gm-Message-State: APjAAAVDBGmDwr75xzxkrJ11j5cy7Mr2O1OMo3J6FEFlmzGdFLav3N63
        7w+Tjr7O8cPUwN1KjDFr2s/aWuA2c6Y=
X-Google-Smtp-Source: APXvYqzHXStUo+f5atgElR1FxqTnQjq0EhGpW0zJixAJbseeVZlQ12PH3zSL0aBgh4+V2oqMYac+Aw==
X-Received: by 2002:a65:64c6:: with SMTP id t6mr418097pgv.392.1579808657640;
        Thu, 23 Jan 2020 11:44:17 -0800 (PST)
Received: from localhost (MIPS-TECHNO.ear1.SanJose1.Level3.net. [4.15.122.74])
        by smtp.gmail.com with ESMTPSA id c18sm3702271pfr.40.2020.01.23.11.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 11:44:16 -0800 (PST)
Message-ID: <5e29f790.1c69fb81.734a2.8d5f@mx.google.com>
Date:   Thu, 23 Jan 2020 11:44:15 -0800
From:   Paul Burton <paulburton@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
CC:     linux-mips@vger.kernel.org
CC:     chenhc@lemote.com, paul.burton@mips.com,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
CC:     linux-mips@vger.kernel.org
Subject: Re: [PATCH 1/3] MIPS: Make DIEI support as a config option
References:  <20200113101501.37985-1-jiaxun.yang@flygoat.com>
In-Reply-To:  <20200113101501.37985-1-jiaxun.yang@flygoat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Jiaxun Yang wrote:
> DI(Disable Interrupt) and EI(Enable Interrupt) instructions is required by
> MIPSR2/MIPSR6, however, it appears to be buggy on some processors such as
> Loongson-3A1000. Thus we make it as a config option to allow disable it at
> compile time with CPU_MIPSR2 selected.

Series applied to mips-next.

> MIPS: Make DIEI support as a config option
>   commit ba9196d2e005
>   https://git.kernel.org/mips/c/ba9196d2e005
>   
>   Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>   Signed-off-by: Paul Burton <paulburton@kernel.org>
> 
> MIPS: Loongson64: Bump ISA level to MIPSR2
>   commit 51522217f65f
>   https://git.kernel.org/mips/c/51522217f65f
>   
>   Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>   Signed-off-by: Paul Burton <paulburton@kernel.org>
> 
> MIPS: Loongson64: Disable exec hazard
>   commit 1306cc0a3091
>   https://git.kernel.org/mips/c/1306cc0a3091
>   
>   Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>   Signed-off-by: Paul Burton <paulburton@kernel.org>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paulburton@kernel.org to report it. ]
