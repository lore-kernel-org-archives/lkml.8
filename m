Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE63C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A5A920829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLnlQR3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgG3Mkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 08:40:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48849 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726581AbgG3Mks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596112847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=spLBUaU7pTQwMzCULpmDoNOw8gMoy0SRz73SDHxe40Y=;
        b=fLnlQR3Xr/sCsoxAc2o+D4b+HNjOZ/s8dMo10Q0jiGpE+yU9MWADWbmSk7/kPA4FUAbBn9
        P4wpJUxSxxgotmBKoluMHYXYuGcr4+qplV0QY8t6AKXW2xJzpm0TdQgb6zbkm/AXJV3RDy
        JjMXVx8Mwt0YzKpDxVEK7S3NgwpDZLc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-FKbEfZn0MDimXbE-cIfoFA-1; Thu, 30 Jul 2020 08:40:45 -0400
X-MC-Unique: FKbEfZn0MDimXbE-cIfoFA-1
Received: by mail-wr1-f72.google.com with SMTP id b18so4853771wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 05:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=spLBUaU7pTQwMzCULpmDoNOw8gMoy0SRz73SDHxe40Y=;
        b=j5GdhJXwuwM7007uBD/ZqR3+O69TaObwovd/I8xNjjav1zPmUQYdpWxEVH8qbRXIGc
         2LqOmAUmfQQnfOwN+oC1mxpI4rAqk2LUqC3zsMySTg608/mgWdoD33gFI+F2xXCnD9zT
         LVQSdTdaw2n23p7pznUTpmFuAIo3mQtALWllAyouaRJ3MfM7vKFdghycu+TXcVFsKYEy
         csFngj2LbW0/F299PZBcYkwZwZ96M4+1OGTLnhZcOuwJjphsYNYzXJk7j9VpawPG/+EH
         w0T0yGzEy8jAUuRxZB6lUKhBqg4vNUuuH9yFC/hXiA514Tq3ZrlBM2ER7/6bfMxVFvdu
         QiNg==
X-Gm-Message-State: AOAM5333nJAYF/vmN0Dr2+W6vqyN6aPy0XAzr3qsNHW9iQPbslJUKJwf
        AsDbo74fnx5HcWt0U8pFGJy6qIaDY0ErZSmE887Pq9nm3P+Fb62zTA9ddiUgKCr10cO4z/tu1Ar
        ABLOIKiqcMH+YARVPr4XTwvO2
X-Received: by 2002:a05:600c:2209:: with SMTP id z9mr12988675wml.70.1596112844132;
        Thu, 30 Jul 2020 05:40:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpjb+yRYzYvCXx+tenz/Sbp5Pj2KjBFIVFHzXy1mJunpxBwKJ7twDtsoWHWqBy54PcSwIg9Q==
X-Received: by 2002:a05:600c:2209:: with SMTP id z9mr12988658wml.70.1596112843907;
        Thu, 30 Jul 2020 05:40:43 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id t25sm8321614wmj.18.2020.07.30.05.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 05:40:43 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] objtool: Move orc outside of check
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mhelsley@vmware.com, mbenes@suse.cz
References: <20200730094143.27494-1-jthierry@redhat.com>
 <20200730094143.27494-3-jthierry@redhat.com>
 <20200730095759.GH2655@hirez.programming.kicks-ass.net>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <dfe69c8f-db70-8366-5601-2592409ce7a0@redhat.com>
Date:   Thu, 30 Jul 2020 13:40:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200730095759.GH2655@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/20 10:57 AM, peterz@infradead.org wrote:
> On Thu, Jul 30, 2020 at 10:41:41AM +0100, Julien Thierry wrote:
>> +		if (file->elf->changed)
>> +			return elf_write(file->elf);
>> +		else
>> +			return 0;
>>   	}
> 
> I think we can do without that else :-)
> 

I did wonder and was not 100% confident about it, but the orc gen will 
always change the file, correct?

-- 
Julien Thierry

