Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E60FC47255
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 820432071A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgELCMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 22:12:41 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34880 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727892AbgELCMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 22:12:41 -0400
X-IronPort-AV: E=Sophos;i="5.73,381,1583164800"; 
   d="scan'208";a="91931189"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 12 May 2020 10:12:38 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id E26BF4BCC89B;
        Tue, 12 May 2020 10:12:34 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 12 May 2020 10:12:35 +0800
Message-ID: <5EBA0611.1070608@cn.fujitsu.com>
Date:   Tue, 12 May 2020 10:12:33 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
CC:     <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <joe@perches.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] tools/perf/util/*.c: Use "%zu" output format for size_t
 type
References: <20200226010818.8639-1-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20200226010818.8639-1-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: E26BF4BCC89B.AF650
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ping!

Thanks,
Xiao Yang
On 2020/2/26 9:08, Xiao Yang wrote:
> Avoid the following errors when building perf on i386:
> -----------------------------------------------
> util/session.c: In function 'perf_session__process_compressed_event':
> util/session.c:91:11: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t {aka unsigned int}' [-Werror=format=]
>    pr_debug("decomp (B): %ld to %ld\n", src_size, decomp_size);
> ...
> til/zstd.c: In function 'zstd_decompress_stream':
> util/zstd.c:102:11: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t {aka unsigned int}' [-Werror=format=]
>      pr_err("failed to decompress (B): %ld ->  %ld, dst_size %ld : %s\n",
> ...
> -----------------------------------------------
> 
> Reported-by: kernel test robot<lkp@intel.com>
> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> ---
>   tools/perf/util/session.c | 2 +-
>   tools/perf/util/zstd.c    | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index d0d7d25b23e3..55c3d2fefd41 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -88,7 +88,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>   		session->decomp_last = decomp;
>   	}
> 
> -	pr_debug("decomp (B): %ld to %ld\n", src_size, decomp_size);
> +	pr_debug("decomp (B): %zu to %zu\n", src_size, decomp_size);
> 
>   	return 0;
>   }
> diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
> index d2202392ffdb..a051237cacf2 100644
> --- a/tools/perf/util/zstd.c
> +++ b/tools/perf/util/zstd.c
> @@ -99,7 +99,7 @@ size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t src_size
>   	while (input.pos<  input.size) {
>   		ret = ZSTD_decompressStream(data->dstream,&output,&input);
>   		if (ZSTD_isError(ret)) {
> -			pr_err("failed to decompress (B): %ld ->  %ld, dst_size %ld : %s\n",
> +			pr_err("failed to decompress (B): %zu ->  %zu, dst_size %zu : %s\n",
>   			       src_size, output.size, dst_size, ZSTD_getErrorName(ret));
>   			break;
>   		}



