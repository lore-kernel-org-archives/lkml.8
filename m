Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E72C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 20:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F2421556
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 20:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599509547;
	bh=EOaPtAh03DeyQBLF3axC14+NF/h3MulP7m20/5/Q5C8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=X2L6Wh3f61KpcQL0kcYbJYR1srf9O8PAhwADrp1YE7KS2bLzNFZxHtsBeAVyp/TEF
	 3QAPRwGEpROqjhdTBYyXYam9BiV2H/5hy8IlX9iTT71xe92LnY021jpKKUYZf8ibYf
	 Av/EMnjEZ3Qx+Ljoew9ABsfFuwJ9kwN7S/UvufHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgIGUMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 16:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbgIGUMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 16:12:21 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7271921556;
        Mon,  7 Sep 2020 20:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599509540;
        bh=EOaPtAh03DeyQBLF3axC14+NF/h3MulP7m20/5/Q5C8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KKif5jRX8IOQ8WTb4utcN3D8+wCpPYWY2XIAkT80zR4sHa9khMmoUJgrVkFSRgVJj
         6Wcn6cr07ZkKlwuCBD3vrniXrzWm6JKKDw8PiDdL/bzw8oPngw040M78WzsOFDICmE
         +BtmCr1sAzo7cEjqL2ton0nsI3i8Zl2qSoXCgZq8=
Date:   Mon, 7 Sep 2020 13:12:17 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     davem@davemloft.net, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv3] selftests: rtnetlink: load fou module for
 kci_test_encap_fou() test
Message-ID: <20200907131217.61643ada@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200907035010.9154-1-po-hsu.lin@canonical.com>
References: <20200907035010.9154-1-po-hsu.lin@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Sep 2020 11:50:10 +0800 Po-Hsu Lin wrote:
> The kci_test_encap_fou() test from kci_test_encap() in rtnetlink.sh
> needs the fou module to work. Otherwise it will fail with:
> 
>   $ ip netns exec "$testns" ip fou add port 7777 ipproto 47
>   RTNETLINK answers: No such file or directory
>   Error talking to the kernel
> 
> Add the CONFIG_NET_FOU into the config file as well. Which needs at
> least to be set as a loadable module.
> 
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>

> diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
> index 7c38a90..a711b3e 100755
> --- a/tools/testing/selftests/net/rtnetlink.sh
> +++ b/tools/testing/selftests/net/rtnetlink.sh
> @@ -520,6 +520,11 @@ kci_test_encap_fou()
>  		return $ksft_skip
>  	fi
>  
> +	if ! /sbin/modprobe -q -n fou; then
> +		echo "SKIP: module fou is not found"
> +		return $ksft_skip
> +	fi
> +	/sbin/modprobe -q fou
>  	ip -netns "$testns" fou add port 7777 ipproto 47 2>/dev/null
>  	if [ $? -ne 0 ];then
>  		echo "FAIL: can't add fou port 7777, skipping test"
> @@ -540,6 +545,7 @@ kci_test_encap_fou()
>  		return 1
>  	fi
>  
> +	/sbin/modprobe -q -r fou

I think the common practice is to not remove the module at the end of
the test. It may be used by something else than the test itself.

>  	echo "PASS: fou"
>  }
>  

