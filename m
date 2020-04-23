Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B59C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E473F20704
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIc1mfjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgDWQRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728865AbgDWQRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:17:04 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD10FC09B041;
        Thu, 23 Apr 2020 09:17:04 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x15so3198422pfa.1;
        Thu, 23 Apr 2020 09:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vY0QAaBd7CT6LQqNfpfJLV9TQ2QbswDpTqEZZg1X1+k=;
        b=oIc1mfjCJ8HdR+eBQzsvdED/L+KObdHZGSYvI3L+KG2y7rreXGlkKGSzhWbSv90+ga
         QG7UBQxN/h49vxDsHntwPyQTAgvPDd9Yy0jjOta4G71KvoybOwzWk4/vuyvSt/oavykg
         CVoY/v9fXa468/msy71dvojL06C65bFs++SXLvBpkuIEwsvDfNP03rFt3BHLaTv8EBCP
         gb1qknPjkTdnl5U459pjiP0QYWyZYex0csYZlIN4CBjdACrZnViDUT0XdnHMpRjOS/d6
         vBCqaBlsoA9f5HirpFYbc8M7erDl9pmoZ5uWPqqr8jAj7TIRNIw6Tid65fMlO2rBN68f
         mpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=vY0QAaBd7CT6LQqNfpfJLV9TQ2QbswDpTqEZZg1X1+k=;
        b=AH1xf5lX9bCivS4DxMzSAIvbJgNzGWfW4u2lwPlsc5X3pPKeqIDtZYBrRqQXa6voX6
         HO6qDjooBeEliwacK6ZDIiIg249tVrbT6/N047SsZw6cmvs2E7Ot4UGez3srs5yAHsz/
         kswdv/SGZlYGk7okhxnbJS2eCdmUSqRO3PADqTGXV4DPYNUIqwUVnqAovvkBRC9CkFzc
         EOOvbiDqcItfWs015qbZUGKzkrRGb7HUGr22eJReXbTW5xCdz50sInwvohCDd3B2nkuB
         E9JgdxhaLfpBBOVUf/4URHOxuJ8Hv7QqIFX+244lIL19UTSXRp3bSBMbKbWR2zYaRUi3
         R2nQ==
X-Gm-Message-State: AGi0PubdED3GuI1vAdxj5R4BoD6varuqLyiiDeVheL0FcFHCpDaL3k0x
        F12qXd2dAuMaoGBpW8LuQJ4=
X-Google-Smtp-Source: APiQypJIG3TkoAAQiGAF6HmslL4OauCf1sKQOkrJX+Its91nL3Qwnw7MLCidG5IJMt9m1o+Kkev5YQ==
X-Received: by 2002:aa7:9305:: with SMTP id 5mr4728423pfj.188.1587658624395;
        Thu, 23 Apr 2020 09:17:04 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p16sm2709956pjz.2.2020.04.23.09.17.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Apr 2020 09:17:03 -0700 (PDT)
Date:   Thu, 23 Apr 2020 09:17:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrej Picej <andpicej@gmail.com>
Cc:     primoz.fiser@norik.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (lm70) Add support for ACPI
Message-ID: <20200423161702.GA139460@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 03:27:33PM +0200, Andrej Picej wrote:
> This commit adds support for lm70 commpatible drivers with systems that
> use ACPI.
> 
> Signed-off-by: Andrej Picej <andpicej@gmail.com>

Applied.

Thanks,
Guenter
