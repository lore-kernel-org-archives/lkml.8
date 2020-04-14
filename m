Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE58CC352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA89D2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QX3DN5JY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633122AbgDNU2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:28:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30544 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633117AbgDNU2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586896081;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=gFhKg1i0fnRjhPnvNhhvH31RVPmlylOwcXirBGzACwY=;
        b=QX3DN5JYUf9GWzqn0d31av65ZTIqf/RONt2+tehFWyY3RVdbM/DHEw35DgP+pxvtExhKVc
        tmbr657l6HSEgZwA8z239lg4EsXAl/aEzMItZflZghjJ2honDtyIh1coOkV3ATduEO1mbn
        KAsQI0nHGopGsVE68Gv+r8PZgtq0m3A=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-xHizUbkgN0Onx25ibWtCJQ-1; Tue, 14 Apr 2020 16:26:18 -0400
X-MC-Unique: xHizUbkgN0Onx25ibWtCJQ-1
Received: by mail-qv1-f72.google.com with SMTP id z16so974157qvo.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=gFhKg1i0fnRjhPnvNhhvH31RVPmlylOwcXirBGzACwY=;
        b=X60Fwmft6oDkwW7VTRSdupWN7g4Qsuuf3W3epfUxbgNMQDqlkgZE1epPr3y/XQwbcX
         smEysJfsYgCm++nHP6ljJwLcXvS0kGTmsvi4G9FGQ5UHu+fK2DLLhPCy90sXV2FgEgTc
         76rVxWfAYa0J0WyUkD/vbHQD/NE//MSCII+pLH9F/Iu4eeZcWHLRrw90i+z4FTKDIK/P
         4kO/czj9yGznY6DjqNGL7e4l4lubN4t0ggfwc5olmwtLYRCoIRNzlNwY1OmCbOSGlYip
         0QCjE6V6w7OTZdKysjTgZbua214q/b8DmzZFUAmzJP5w9P6hiysUT55hV+ZYGuTpJ65A
         OA+A==
X-Gm-Message-State: AGi0Puap7fATEhzWWijPW2rknHIHwYipgKEzY80LjIlJc1ZXw+MM/j+7
        NtWYD5Bye9pE0DNMK5Iznbwb/8ZN42lG/5QDHYv6HUOlacWJGyS/iMmErrnZt1pWnk5O3yBS/cb
        1I1n0vKcsP81CAhizCzEybmn4
X-Received: by 2002:ad4:55eb:: with SMTP id bu11mr1771408qvb.192.1586895977467;
        Tue, 14 Apr 2020 13:26:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypLL/739Bunp9PWRhInCCopdTucT0TPb7bitw7FUwX4bvc+D2WRR+F0MR9Hi3wsAxrEA6InUdg==
X-Received: by 2002:ad4:55eb:: with SMTP id bu11mr1771387qvb.192.1586895977300;
        Tue, 14 Apr 2020 13:26:17 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id g187sm10909209qkf.115.2020.04.14.13.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:26:16 -0700 (PDT)
Date:   Tue, 14 Apr 2020 13:26:15 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: Re: [PATCH] tpm: fix wrong return value in tpm_pcr_extend
Message-ID: <20200414202615.stnurisucqxblenj@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
References: <20200414114226.96691-1-tianjia.zhang@linux.alibaba.com>
 <76d46ffbad294a6385779c29c4e5cafd@huawei.com>
 <20200414193542.GB13000@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200414193542.GB13000@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Apr 14 20, Jarkko Sakkinen wrote:
>On Tue, Apr 14, 2020 at 11:55:43AM +0000, Roberto Sassu wrote:
>> > -----Original Message-----
>> > From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
>> > owner@vger.kernel.org] On Behalf Of Tianjia Zhang
>> > Sent: Tuesday, April 14, 2020 1:42 PM
>> > To: peterhuewe@gmx.de; jarkko.sakkinen@linux.intel.com; jgg@ziepe.ca;
>> > arnd@arndb.de; gregkh@linuxfoundation.org; zhang.jia@linux.alibaba.com
>> > Cc: linux-integrity@vger.kernel.org; linux-kernel@vger.kernel.org;
>> > tianjia.zhang@linux.alibaba.com
>> > Subject: [PATCH] tpm: fix wrong return value in tpm_pcr_extend
>> >
>> > For the algorithm that does not match the bank, a positive
>> > value EINVAL is returned here. I think this is a typo error.
>> > It is necessary to return an error value.
>>
>> Yes, thanks.
>>
>> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
>
>Happen to have the commit ID at hand for fixes?
>
>Thanks.
>
>/Jarkko
>

9f75c8224631 ("KEYS: trusted: correctly initialize digests and fix locking issue")

