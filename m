Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D6DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321C9206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsYsRiGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgGXR4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgGXR4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:56:24 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0652C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:56:24 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id w17so7628177otl.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=crOELoHuO5UyCHwlOjSs28KQsKC5splMHLSUwDt5LfI=;
        b=WsYsRiGQq/Ne+jIHDnyOUOBwFQMSO8mx0SFa5Iv16nUbj/GxaWT7Oo97hPT3V+8i8E
         6P0QHd/ggEPcUPzWs5wlZmFqABDmPOc2y1onfiJiVNoFIeGDjo+N6AvBm97eWfW3FMrc
         ap8Xb95k9VObNlQB34nanTazZMzARB4pnkCmjmUiEZdMftNaIJ2X3erRf9iF9/e8TkWN
         1PwAUM+dq/TbWBjUpfNAaEd7hHVqv8iQo3Rr+kk1IHG7kW03EFsCE1ppj42sdqT2IPMX
         hZSwl8PKiwcp8gqEyven9Z1+daim39qVhgTxjg951sWWqg/t8T/G5kZe0P7VQaq9R9gB
         kQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=crOELoHuO5UyCHwlOjSs28KQsKC5splMHLSUwDt5LfI=;
        b=CgfhsVC5AYHnNrOFxdISSZc6kaA06INq3EmJw5u9BiFNQZ0b2iieaYUL/ipt3B0vyd
         Ad5HGkSikzfoX7gcSjreu3XZRPixQaXXviuZrTPhUxsj/+yolty2R1uC0F9NBxdUxc19
         StVFCoD2GPwVjkR7FDL2QjYkjON+mrkcRERRKBx9PvJ+HvZ5NkVEEJirD69Y4x/xKlkj
         jcdoDaDYyL9xMQtudo7omxv+sYWbruHfCZWjj/8ZKYPzj66z/waokjXXjLV/omF8LUOW
         R5QPrhmDbrQo25SR3KUWXmoXj/PTqdW5zWD4I1I/cFziZMzt4QOHpMo7idRfJbKPhNof
         d1Tg==
X-Gm-Message-State: AOAM5334MyZnKvblEw+4kPqDcB2GBotFCGrHgdBlWGd+tk/l4yDE5C3m
        bdKl7th5leBfK8QJC4T6z13aKCcl
X-Google-Smtp-Source: ABdhPJzB+ySmpkZQodsm5CaoU4cuc/3IVfPnt5raiqSbjqvrnqiwWCuLSYICKSu1uPDuHLYpsteMxg==
X-Received: by 2002:a9d:5915:: with SMTP id t21mr9702226oth.372.1595613383978;
        Fri, 24 Jul 2020 10:56:23 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id n7sm1559472ooo.38.2020.07.24.10.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 10:56:23 -0700 (PDT)
Subject: Re: [PATCH] Staging: rtl8188eu: rtw_mlme: Fix uninitialized variable
 authmode
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kjlu@umn.edu,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Michael Straube <straube.linux@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200724122957.30411-1-dinghao.liu@zju.edu.cn>
 <20200724132836.GC316746@kroah.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <66d9502e-682f-6ccd-ef90-138feee0c2ae@lwfinger.net>
Date:   Fri, 24 Jul 2020 12:56:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724132836.GC316746@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/20 8:28 AM, Dinghao Liu wrote:
> The variable authmode will keep uninitialized if neither if
> statements used to initialize this variable are not triggered.

Besides Greg's comment, you need to re-parse this sentence. I realize that 
English is probably not your first language, but this one is not what you meant.

You likely meant "The variable authmode will remain uninitialized if all 
statements used to initialize this variable are not triggered."

A possible (line-wrapped) patch to quiet the tools would be:

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c 
b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index 9de2d421f6b1..9e4d78bc9a2e 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -1729,9 +1729,11 @@ int rtw_restruct_sec_ie(struct adapter *adapter, u8 
*in_ie, u8 *out_ie, uint in_
         if ((ndisauthmode == Ndis802_11AuthModeWPA) ||
             (ndisauthmode == Ndis802_11AuthModeWPAPSK))
                 authmode = _WPA_IE_ID_;
-       if ((ndisauthmode == Ndis802_11AuthModeWPA2) ||
-           (ndisauthmode == Ndis802_11AuthModeWPA2PSK))
+       else if ((ndisauthmode == Ndis802_11AuthModeWPA2) ||
+                (ndisauthmode == Ndis802_11AuthModeWPA2PSK))
                 authmode = _WPA2_IE_ID_;
+       else
+               authmode = 0;

         if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
                 memcpy(out_ie + ielength, psecuritypriv->wps_ie, 
psecuritypriv->wps_ie_len);


Yes, in this routine, it would be possible for authmode to not be set; however, 
later code only compares it to either _WPA_IE_ID_ or _WPA2_IE_ID_. It is never 
used in a way that an unset value could make the program flow be different by 
arbitrarily setting the value to zero. Thus your statement "Then authmode may 
contain a garbage value and influence the execution flow of this function." is 
false.

Larry
