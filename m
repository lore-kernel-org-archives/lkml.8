Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E48C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A98F20768
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="B1rU+tFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbgFOTE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 15:04:29 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.147]:11551 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729844AbgFOTEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 15:04:25 -0400
X-Greylist: delayed 1396 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jun 2020 15:04:23 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 38527400E3D50
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 13:41:05 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ku2bj074DSxZVku2bjBkCA; Mon, 15 Jun 2020 13:41:05 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3zGnBReUhGQj0m2RlHAZJ7edlV+NDSZkuOldeLUurWo=; b=B1rU+tFpJcLZDJGNCa8yaXE411
        sqXS/mdJVhcwQIWUzmaNut4kUCpB0GByd/kyobHPsqlA/kkFS0O5GAcGr3cGbooCVB/fvvFeH5BEl
        6SLQgiXXOqSgWHLifOT6aeTqJu41eHTVebzHodeJ14IACd0MTQZ34YB47xOo8UkV8r+yrDPXs70hB
        /6i1a9MxCzUMw7+qkXG8qIXCdawh7P3tNaKFgddOYJlHU+WIVLWXeyWqbkWt8hA5r5gT6ejTd4XC0
        A/P/G2ovfXTh2OTyphIbBAEqxyybKshqWKtZPi6upPfQZ7947R74vCIWVCS569sQprp4hzTZLp6VP
        MT2JOIAA==;
Received: from [189.207.59.248] (port=54928 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <garsilva@embeddedor.com>)
        id 1jku2a-000R1p-P7; Mon, 15 Jun 2020 13:41:04 -0500
Subject: Re: [Cocci] [PATCH] coccinelle: misc: add array_size_dup script to
 detect missed overlow checks
To:     Denis Efremov <efremov@linux.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
References: <20200615102045.4558-1-efremov@linux.com>
 <202006151123.3C2CB7782@keescook>
 <a28543e5-4f93-bf16-930b-42d7b24ab902@linux.com>
From:   "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Autocrypt: addr=garsilva@embeddedor.com; keydata=
 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
 AP7RWS474w==
Message-ID: <4dd9c371-0c37-a4bb-e957-3848cb1a13ff@embeddedor.com>
Date:   Mon, 15 Jun 2020 13:46:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <a28543e5-4f93-bf16-930b-42d7b24ab902@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.207.59.248
X-Source-L: No
X-Exim-ID: 1jku2a-000R1p-P7
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.7]) [189.207.59.248]:54928
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/20 13:35, Denis Efremov wrote:
> 
> 
> On 6/15/20 9:23 PM, Kees Cook wrote:
>> On Mon, Jun 15, 2020 at 01:20:45PM +0300, Denis Efremov wrote:
>>> Detect an opencoded expression that is used before or after
>>> array_size()/array3_size()/struct_size() to compute the same size.
>>>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> Signed-off-by: Denis Efremov <efremov@linux.com>
>>
>> Oh, very cool! How much does this find currently?
>>
> 
> opencoded expression before the function call:
> ./drivers/net/ethernet/cavium/liquidio/request_manager.c:98:34-59: WARNING: array_size is used down the code (line 103) to compute the same size
> ./drivers/media/test-drivers/vivid/vivid-core.c:1120:26-34: WARNING: array_size is used down the code (line 1122) to compute the same size
> ./drivers/scsi/megaraid/megaraid_sas_fusion.c:5184:11-31: WARNING: array_size is used down the code (line 5191) to compute the same size
> ./drivers/scsi/megaraid/megaraid_sas_fusion.c:5200:2-37: WARNING: array_size is used down the code (line 5207) to compute the same size
> ./fs/cifs/misc.c:853:17-39: WARNING: array_size is used down the code (line 858) to compute the same size
> ./fs/cifs/misc.c:863:17-38: WARNING: array_size is used down the code (line 868) to compute the same size
> ./drivers/scsi/fnic/fnic_trace.c:562:25-48: WARNING: array_size is used down the code (line 566) to compute the same size
> 
> opencoded expression after the function call:
> ./net/ethtool/ioctl.c:1976:55-66: WARNING: array_size is already used (line 1957) to compute the same size
> ./net/ethtool/ioctl.c:1921:55-66: WARNING: array_size is already used (line 1909) to compute the same size
> ./drivers/net/ethernet/cavium/liquidio/request_manager.c:111:29-54: WARNING: array_size is already used (line 103) to compute the same size
> ./drivers/staging/rts5208/ms.c:2309:55-56: WARNING: array_size is already used (line 2305) to compute the same size
> ./drivers/video/fbdev/core/fbcon.c:642:52-53: WARNING: array3_size is already used (line 638) to compute the same size
> ./drivers/video/fbdev/core/fbcon.c:679:47-48: WARNING: array3_size is already used (line 638) to compute the same size
> ./drivers/usb/misc/sisusbvga/sisusb_con.c:1229:54-56: WARNING: array_size is already used (line 1226) to compute the same size
> ./fs/afs/cmservice.c:271:45-46: WARNING: array3_size is already used (line 267) to compute the same size
> ./drivers/mtd/ftl.c:270:49-65: WARNING: array_size is already used (line 266) to compute the same size
> ./drivers/scsi/qla2xxx/tcm_qla2xxx.c:1608:6-42: WARNING: array_size is already used (line 1605) to compute the same size
> ./drivers/scsi/qla2xxx/tcm_qla2xxx.c:1613:8-44: WARNING: array_size is already used (line 1605) to compute the same size
> ./drivers/net/ppp/bsd_comp.c:439:13-37: WARNING: array_size is already used (line 409) to compute the same size
> ./drivers/net/wireless/ath/ath5k/debug.c:957:20-21: WARNING: array_size is already used (line 934) to compute the same size
> ./drivers/scsi/fnic/fnic_trace.c:575:3-26: WARNING: array_size is already used (line 566) to compute the same size
> ./drivers/scsi/fnic/fnic_trace.c:592:32-53: WARNING: array_size is already used (line 580) to compute the same size
> ./drivers/scsi/fnic/fnic_trace.c:504:30-51: WARNING: array_size is already used (line 492) to compute the same size
> ./drivers/staging/rts5208/rtsx_chip.c:1475:17-18: WARNING: array_size is already used (line 1458) to compute the same size
> ./kernel/kexec_file.c:917:8-25: WARNING: array_size is already used (line 913) to compute the same size
> ./drivers/rapidio/devices/rio_mport_cdev.c:984:8-25: WARNING: array_size is already used (line 978) to compute the same size
> ./fs/reiserfs/bitmap.c:1463:22-37: WARNING: array_size is already used (line 1459) to compute the same size
> 
> duplicate calls:
> ./drivers/media/test-drivers/vivid/vivid-core.c:1125:59-60: WARNING: same array_size (line 1122)
> ./drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:142:36-37: WARNING: same array_size (line 138)
> ./drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:129:41-42: WARNING: same array3_size (line 123)
> ./drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:146:40-41: WARNING: same array3_size (line 123)
> ./drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:146:40-41: WARNING: same array3_size (line 129)
> ./drivers/net/ethernet/cavium/liquidio/octeon_droq.c:289:27-28: WARNING: same array_size (line 284)
> ./drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c:857:59-60: WARNING: same struct_size (line 854)
> ./fs/f2fs/super.c:3478:34-35: WARNING: same array_size (line 3478)
> ./drivers/net/wireless/zydas/zd1211rw/zd_usb.c:1637:45-46: WARNING: same struct_size (line 1634)
> ./drivers/net/ethernet/netronome/nfp/flower/cmsg.c:221:49-50: WARNING: same struct_size (line 219)
> ./drivers/staging/rts5208/rtsx_chip.c:1458:36-37: WARNING: same array_size (line 1454)
> ./drivers/net/ethernet/neterion/vxge/vxge-config.c:2664:59-60: WARNING: same array_size (line 2654)


Awesome! I'll take a look into this. :)

Thanks, Denis!
--
Gustavo

