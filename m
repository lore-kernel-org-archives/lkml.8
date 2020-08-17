Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68005C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4362220738
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597658148;
	bh=JvGuTkC1cOJcFzi6SmhXDEslKd4rVs6/+DAvt3zZ2e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C1qIpZ0YQQwKkFE7MzrhxzHl/6NiTVAJ3WuOgJjxJmzkW/B8ItkWJhD1ksqfFyUI6
	 B19rJdHC7El1lqza6l4Z8VHwsuBGfTs+5EEHs3q9GMyvRsbCfDWNxVaYZi105j3xph
	 NCHZ4bA+ZTr6E3SDzzflsRMdcn7h3NftnROJxaKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgHQJzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:55:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43306 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgHQJzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:55:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id v12so16758544ljc.10;
        Mon, 17 Aug 2020 02:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4nEjwbn3JPPjnvjnDGJFs8xT2ZWqJn/zT9YAgEPeUdk=;
        b=D2FszZtqGbi9EHUF5WKi5yu17qQwKpl2t+F7h87P9O8j+TUNc7aAg3xfAq4eTKNbRR
         Ikwz4xgaXYjlRJGvif3zPY6HRKUYMiTubWcZ+hm6fTFVrJ4HKR0jWFAwoIfyPa0+0LLE
         WcDzoNzlnYzpWpwwR4HR0knC/Xcjgh+nM4C4Oh8XUuWYy8skcPsjjMGVyZfkmg+L9XJk
         jP4lYCTV53qm/lVgtYgVr14ACiG8/xegYIkSVJiosy7a5f/A4VOloTRpfXUwXJbokQ0B
         icaF6/6r4bE+DvOvTEJcD1N+P6p2Nc7iUqrzTbEEhT3f8mqZd7EymYe3f1AB3cGSdS0p
         LFcA==
X-Gm-Message-State: AOAM530BsHkDDoTmql1iGiPkVf9Qx1YAiqyX1CD4C+NyXOZMwWHbKAt2
        hckn2DYJ54amUTMA8UdkmNA=
X-Google-Smtp-Source: ABdhPJzuju/OypiGpEJSlFr7KcuLb4mAH49KUa6Y1vdxeC1rNvCO0+BsGDT7bkv8ZXaS8LfJuDiNog==
X-Received: by 2002:a2e:91d2:: with SMTP id u18mr7274231ljg.436.1597658143751;
        Mon, 17 Aug 2020 02:55:43 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id 185sm4913882ljf.82.2020.08.17.02.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 02:55:42 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1k7brh-00010R-67; Mon, 17 Aug 2020 11:55:41 +0200
Date:   Mon, 17 Aug 2020 11:55:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     =?utf-8?B?UGjDuiBMxrB1?= An <luuanphu@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, Phu Luu <Phu.Luu@silabs.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brant Merryman <Brant.Merryman@silabs.com>,
        Richard Hendricks <Richard.Hendricks@silabs.com>,
        "hungnd3@fsoft.com.vn" <hungnd3@fsoft.com.vn>
Subject: Re: [PATCH v3 2/2] USB: serial: cp210x: Proper RTS control when
 buffers fill
Message-ID: <20200817095541.GA3383@localhost>
References: <ECCF8E73-91F3-4080-BE17-1714BC8818FB@silabs.com>
 <20200626074206.GP3334@localhost>
 <20200706101834.GI3453@localhost>
 <CAP847ynZDozdA0kDEo6Zjuk0LOeaiTyW_fnU89hnFUD8ntL8uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP847ynZDozdA0kDEo6Zjuk0LOeaiTyW_fnU89hnFUD8ntL8uw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 09:24:05AM +0700, Phú Lưu An wrote:
> Hi Johan,
> 
> My customer asked me when this patch is applied to the community. So, could
> you please tell me when it appears in a various distributions?

You'll have to ask the distributions about that.

The patch in question is in Linus's tree since about two weeks and
should be picked up and backported to the stable trees soon:

	c7614ff9b73a ("USB: serial: cp210x: re-enable auto-RTS on open")

Johan
