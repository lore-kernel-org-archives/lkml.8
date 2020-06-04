Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D79EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 06:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E044A207DA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 06:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BlBWPqpf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgFDGqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 02:46:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48690 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgFDGqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 02:46:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0546c2CR182582;
        Thu, 4 Jun 2020 06:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=vUCYjp1f2wNESYetrOp1ZqmW5F/o/FmwplfPJxUOq/I=;
 b=BlBWPqpf/PAKOO+PwXnUCnQDAX4S9pnxguIs9OMO5U28MBvSl5RODQ1HT8XkhT7qbhNF
 +98WlrIe5+MKY2fQPvv2khmj8j7rCy8+eh+Q3XYBJN4dZ2Xpk8H20rKEJCndsF6I2yt3
 dNxJ7FJ/AjH4yuQ9SvK8tZYHNNtGB2K1I579wIY/IYN35odV1W1hx5oy2/N1M/gQpQrM
 p/twRrXqlnAmC4M3rows4W88LNsdPvB+3vKKtbyxludRb+L3vyd8Cyv186PcYO/bl/2C
 Fh5DmC3gY8ndVv/CiS89B6mTqPEHaUt0n0044T+ypPxvsKa23gVvqOyD8Shl+DWpQt0K Uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31bewr4x61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 04 Jun 2020 06:45:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0546c4iJ186253;
        Thu, 4 Jun 2020 06:43:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 31dju4gnba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jun 2020 06:43:51 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0546hn2R004470;
        Thu, 4 Jun 2020 06:43:49 GMT
Received: from [10.159.230.80] (/10.159.230.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 23:43:49 -0700
Subject: Re: [PATCH 1/1] nvme-fcloop: verify wwnn and wwpn format
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-nvme@lists.infradead.org, james.smart@broadcom.com
Cc:     sagi@grimberg.me, linux-kernel@vger.kernel.org,
        chaitanya.kulkarni@wdc.com, hch@lst.de
References: <20200526042118.17836-1-dongli.zhang@oracle.com>
Message-ID: <38a2cfb9-df2a-c5cb-6797-2b96ef049c7c@oracle.com>
Date:   Wed, 3 Jun 2020 23:43:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200526042118.17836-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006040043
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=2 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006040043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

May I get feedback for this?

For the first time I use fcloop, I set:

# echo "wwnn=0x3,wwpn=0x1" > /sys/class/fcloop/ctl/add_target_port

However, I would not be able to move forward if I use "0x3" or "0x1" for nvme-fc
target or host further. Instead, the address and port should be
0x0000000000000003 and 0x0000000000000001.

This patch would sync the requirements of input format for nvme-fc and
nvme-fcloop, unless this would break existing test suite (e.g., blktest).

Thank you very much!

Dongli Zhang

On 5/25/20 9:21 PM, Dongli Zhang wrote:
> The nvme host and target verify the wwnn and wwpn format via
> nvme_fc_parse_traddr(). For instance, it is required that the length of
> wwnn to be either 21 ("nn-0x") or 19 (nn-).
> 
> Add this verification to nvme-fcloop so that the input should always be in
> hex and the length of input should always be 18.
> 
> Otherwise, the user may use e.g. 0x2 to create fcloop local port, while
> 0x0000000000000002 is required for nvme host and target. This makes the
> requirement of format confusing.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  drivers/nvme/target/fcloop.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index f69ce66e2d44..14124e6d4bf2 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -43,6 +43,17 @@ static const match_table_t opt_tokens = {
>  	{ NVMF_OPT_ERR,		NULL		}
>  };
>  
> +static int fcloop_verify_addr(substring_t *s)
> +{
> +	size_t blen = s->to - s->from + 1;
> +
> +	if (strnlen(s->from, blen) != NVME_FC_TRADDR_HEXNAMELEN + 2 ||
> +	    strncmp(s->from, "0x", 2))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static int
>  fcloop_parse_options(struct fcloop_ctrl_options *opts,
>  		const char *buf)
> @@ -64,14 +75,16 @@ fcloop_parse_options(struct fcloop_ctrl_options *opts,
>  		opts->mask |= token;
>  		switch (token) {
>  		case NVMF_OPT_WWNN:
> -			if (match_u64(args, &token64)) {
> +			if (fcloop_verify_addr(args) ||
> +			    match_u64(args, &token64)) {
>  				ret = -EINVAL;
>  				goto out_free_options;
>  			}
>  			opts->wwnn = token64;
>  			break;
>  		case NVMF_OPT_WWPN:
> -			if (match_u64(args, &token64)) {
> +			if (fcloop_verify_addr(args) ||
> +			    match_u64(args, &token64)) {
>  				ret = -EINVAL;
>  				goto out_free_options;
>  			}
> @@ -92,14 +105,16 @@ fcloop_parse_options(struct fcloop_ctrl_options *opts,
>  			opts->fcaddr = token;
>  			break;
>  		case NVMF_OPT_LPWWNN:
> -			if (match_u64(args, &token64)) {
> +			if (fcloop_verify_addr(args) ||
> +			    match_u64(args, &token64)) {
>  				ret = -EINVAL;
>  				goto out_free_options;
>  			}
>  			opts->lpwwnn = token64;
>  			break;
>  		case NVMF_OPT_LPWWPN:
> -			if (match_u64(args, &token64)) {
> +			if (fcloop_verify_addr(args) ||
> +			    match_u64(args, &token64)) {
>  				ret = -EINVAL;
>  				goto out_free_options;
>  			}
> @@ -141,14 +156,16 @@ fcloop_parse_nm_options(struct device *dev, u64 *nname, u64 *pname,
>  		token = match_token(p, opt_tokens, args);
>  		switch (token) {
>  		case NVMF_OPT_WWNN:
> -			if (match_u64(args, &token64)) {
> +			if (fcloop_verify_addr(args) ||
> +			    match_u64(args, &token64)) {
>  				ret = -EINVAL;
>  				goto out_free_options;
>  			}
>  			*nname = token64;
>  			break;
>  		case NVMF_OPT_WWPN:
> -			if (match_u64(args, &token64)) {
> +			if (fcloop_verify_addr(args) ||
> +			    match_u64(args, &token64)) {
>  				ret = -EINVAL;
>  				goto out_free_options;
>  			}
> 
