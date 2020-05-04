Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B64C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F299E206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgEDKVg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 06:21:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60159 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbgEDKVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 06:21:34 -0400
Received: from mail-pj1-f72.google.com ([209.85.216.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jVYE7-0003Zg-Kw
        for linux-kernel@vger.kernel.org; Mon, 04 May 2020 10:21:31 +0000
Received: by mail-pj1-f72.google.com with SMTP id x6so9689273pjg.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 03:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=h7D6iCvSYfgoJ0/q+VkOaS0WB3LBWJkenY5VTPHrol0=;
        b=qbkVcrmNR2ETu2OkRhjXjKs7yeIB8X6SQ/DyS+AP8540NC1LA3KFXZN+cteaYzky65
         ugpjf1vG2JpLvi/89u6Qmpeq4wYyDGSXZ5GSFcDTaH3WMEelMt5ru2guy5R934Jd1ryK
         S4V56ZWED196+xaJE2SvXkmTY36HK40TdPLO8PhL+aF3reSsUYH5oCtMzC3oDVzWxaBq
         zhsLSzcNXDa7KxmYAXZXmjyr63WvARHQLQmWvcaYkxAmbqYEFgcsT/LYl8ZX+h7pwYJr
         wK9h9u/kKsulZgO5+H3trHz8T1GzYy7Xo3Maz/JHmbu3nT76C4kPh0O2IHgGY3axVJON
         mlcQ==
X-Gm-Message-State: AGi0PuZZKwJajLnWYIt2SISxrjptPfMB0n0UDOHTSNKzERVQuPlzoz5E
        3IX1hjyHxXt/6+24twlJDMp2A1FGkm5ZC0E6asqYlzAZiWv0iCxV6GniACFBZSUlnhuZYXg7qLE
        D5h0tDt/OqtCdXsgeDilEi7bLpMvB29oVWPzfNj0PAA==
X-Received: by 2002:a17:90a:1a46:: with SMTP id 6mr16314231pjl.111.1588587690159;
        Mon, 04 May 2020 03:21:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypK1TaaYrbGAUh0JRSjb7l3XGllVSeGGzfEuzovcImb9hj5Q8DvAB1yL4wcRdnKlIltdbQb/NQ==
X-Received: by 2002:a17:90a:1a46:: with SMTP id 6mr16314204pjl.111.1588587689780;
        Mon, 04 May 2020 03:21:29 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id nl10sm6956603pjb.41.2020.05.04.03.21.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 03:21:28 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] xhci: Prevent runtime suspend all the time with
 XHCI_RESET_ON_RESUME quirk
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <6fca4532-b4a2-9730-bd96-5ac15357f752@intel.com>
Date:   Mon, 4 May 2020 18:21:26 +0800
Cc:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <E9818D15-2E68-47BA-9548-205CB43566EA@canonical.com>
References: <20200504091952.15820-1-kai.heng.feng@canonical.com>
 <1588585655.13662.5.camel@suse.com>
 <88A0FF32-C7D7-4E49-8470-FE23401371BD@canonical.com>
 <6fca4532-b4a2-9730-bd96-5ac15357f752@intel.com>
To:     Mathias Nyman <mathias.nyman@intel.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 4, 2020, at 18:13, Mathias Nyman <mathias.nyman@intel.com> wrote:
> 
> On 4.5.2020 13.02, Kai-Heng Feng wrote:
>> 
>> 
>>> On May 4, 2020, at 17:47, Oliver Neukum <oneukum@suse.com> wrote:
>>> 
>>> Am Montag, den 04.05.2020, 17:19 +0800 schrieb Kai-Heng Feng:
>>>> Etron EJ168 USB 3.0 Host Controller stops working after S3, if it was
>>>> runtime suspended previously:
>>>> [  370.080359] pci 0000:02:00.0: can't change power state from D3cold to D0 (config space inaccessible)
>>> 
>>> Apparently this controller has issues with D3cold
>>> 
>>>> [  370.080477] xhci_hcd 0000:04:00.0: can't change power state from D3cold to D0 (config space inaccessible)
>>>> [  370.080532] pcieport 0000:00:1c.0: DPC: containment event, status:0x1f05 source:0x0200
>>>> [  370.080533] pcieport 0000:00:1c.0: DPC: ERR_FATAL detected
>>>> [  370.080536] xhci_hcd 0000:04:00.0: can't change power state from D3hot to D0 (config space inaccessible)
>>>> [  370.080552] xhci_hcd 0000:04:00.0: AER: can't recover (no error_detected callback)
>>>> [  370.080566] usb usb3: root hub lost power or was reset
>>>> [  370.080566] usb usb4: root hub lost power or was reset
>>>> [  370.080572] xhci_hcd 0000:04:00.0: Host halt failed, -19
>>>> [  370.080574] xhci_hcd 0000:04:00.0: Host not accessible, reset failed.
>>>> [  370.080575] xhci_hcd 0000:04:00.0: PCI post-resume error -19!
>>>> [  370.080586] xhci_hcd 0000:04:00.0: HC died; cleaning up
>>>> 
>>>> This can be fixed by not runtime suspend the controller at all.
>>>> 
>>>> So instead of conditionally runtime suspend the controller, always
>>>> prevent runtime suspend with XHCI_RESET_ON_RESUME quirk.
>>> 
>>> What does that do to other controllers that can do runtime suspend
>>> under the current scheme?
>> 
>> Ok, I'll add a new quirk specific to this controller.
>> 
>> Kai-Heng
> 
> Host shouldn't runtime suspend by default unless set by userspace, or
> it has XHCI_DEFAULT_PM_RUNTIME_ALLOW quirk set.  

In this case, runtime suspend is indeed enabled by userspace.
However we should still disable it at kernel side to prevent any bug.

Kai-Heng

> 
> -Mathias

