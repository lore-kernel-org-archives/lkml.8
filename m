Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F7BC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 04:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E2FD2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 04:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgDUEvt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 00:51:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36627 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgDUEvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 00:51:49 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jQkst-0005se-4t
        for linux-kernel@vger.kernel.org; Tue, 21 Apr 2020 04:51:47 +0000
Received: by mail-pl1-f198.google.com with SMTP id c7so10577825plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 21:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yHVBi4+q+DxGUgmkg/YNM3PtmSPedofWtuQ7gpqgf8c=;
        b=M6hyJRkfK+KnvT5EzasLZ5r4cC7N5Lu6Mv1H3lGZN5svkQpl9BGTeXp/zHIiZn/VmP
         xmjbEyqepkh3McppN2O1Pput2F9A4k17rgZCGnZVuEDOBJn1an7qGcZlnrUcR5NfG5Kk
         OZTIs7/+Yn3QY12/epjAu1jHg0+sTVxggmNoiL9AH1oDDOXTijl7P+X3iI7AMLAE8j9u
         rOmQiYKaVLUdM8GCvLWFZbnX/YUi3JZrT61fDkZ1TTakGkTJb70dz/coEwxcbY/IR+iG
         mScnPD0hC9+CDTvGDGA80h0+6S5t2t6H9D8yMwq8/hgmetWNElZaMxUky3T2Le5Qeb4w
         1O+g==
X-Gm-Message-State: AGi0PuaPOD1Io6/j/1EVbvel6jnpKlrHIl6FXDV254JnjQWZJ4Rc4RRd
        43F3xCr9Y6awxFdexi9lbfSqcS9DldVppAsJ7J3amnQkUFZVBgDTn696X0Bzgj5mV+AQ+qoVdzo
        hWaLVPx/yacI+o1jXWnNoNDJx2fv7pFCEn9bcs51kaQ==
X-Received: by 2002:aa7:969b:: with SMTP id f27mr19363280pfk.116.1587444705579;
        Mon, 20 Apr 2020 21:51:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypLwkVfZvPWVo80wH2SVlwC4/6KQbeXPP33zsYsSRBohoLtwxEhc5LDS6aRVK5+sLiXn4sZWRQ==
X-Received: by 2002:aa7:969b:: with SMTP id f27mr19363264pfk.116.1587444705283;
        Mon, 20 Apr 2020 21:51:45 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id mq6sm1074269pjb.38.2020.04.20.21.51.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 21:51:44 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] nvme/pci: Use Discard instead of Write Zeroes on SK hynix
 SC300
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <BYAPR04MB49658C7772879D7BA5A6E62D86D90@BYAPR04MB4965.namprd04.prod.outlook.com>
Date:   Tue, 21 Apr 2020 12:51:43 +0800
Cc:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <39EC5974-AD83-411F-8494-70EC79DBB7ED@canonical.com>
References: <20200417083641.28205-1-kai.heng.feng@canonical.com>
 <BYAPR04MB49658C7772879D7BA5A6E62D86D90@BYAPR04MB4965.namprd04.prod.outlook.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 18, 2020, at 03:25, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com> wrote:
> 
> On 04/17/2020 01:37 AM, Kai-Heng Feng wrote:
>> After commit 6e02318eaea5 ("nvme: add support for the Write Zeroes
>> command"), SK hynix SC300 becomes very slow with the following error
>> message:
>> [  224.567695] blk_update_request: operation not supported error, dev nvme1n1, sector 499384320 op 0x9:(WRITE_ZEROES) flags 0x1000000 phys_seg 0 prio class 0]
>> 
>> Use quirk NVME_QUIRK_DEALLOCATE_ZEROES to workaround this issue.
> Can you share
> nvme id-ctrl -H /dev/nvme0 | grep oncs -A 8
> output?
> 

$ sudo nvme id-ctrl -H /dev/nvme0 | grep oncs -A 8
oncs      : 0x1f
  [7:7] : 0     Verify Not Supported
  [6:6] : 0     Timestamp Not Supported
  [5:5] : 0     Reservations Not Supported
  [4:4] : 0x1   Save and Select Supported
  [3:3] : 0x1   Write Zeroes Supported
  [2:2] : 0x1   Data Set Management Supported
  [1:1] : 0x1   Write Uncorrectable Supported
  [0:0] : 0x1   Compare Supported

