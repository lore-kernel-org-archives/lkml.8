Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F34C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0FF20774
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yh3DLpJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgCXQ2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:28:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42620 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgCXQ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:28:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OGDKIV071454;
        Tue, 24 Mar 2020 16:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=O2BVh03YvNi1joghI7zvQ/8mPcvJPWxXuGFSrPPipr8=;
 b=yh3DLpJ+6PiKNrEk1LyNDTZnktsvzbFnXxipD84INpShisnxCxmQabtyHAM4eCukdxu0
 1LC2REVBAQ7cLdLRNDDc8h7f0OvJhcaImHXrEJg/Zj2F9Kcg4yALJ0r1hibEZKt4yTxn
 Xsrxc+3ZN1Fbm0GqOJpa1zsHwVUCABU9D+hdbjZpCkthBTQ/W7wLRx7KzM2F0WDLH1dl
 FnolCG0fyNS1iLcNpMt3YRjAAmqByP0m1eU6usX2iTVq+BIcP9gPuA6yVPMltZ7al72X
 jmU7I5kIKMjsBaEG69zizjS0LaiEfm+MlShtyK/c8kY2nHxNx2dNajTU1aKsm2T4hh60 pQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ywavm5bqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 16:27:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OGJnkO185961;
        Tue, 24 Mar 2020 16:27:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2yxw6n1tbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 16:27:49 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02OGRmWk001475;
        Tue, 24 Mar 2020 16:27:48 GMT
Received: from [10.175.222.8] (/10.175.222.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Mar 2020 09:27:48 -0700
Subject: Re: [PATCH 12/12] device-dax: Introduce 'mapping' devices
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-mm@kvack.org, dave.hansen@linux.intel.com, hch@lst.de,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158500774067.2088294.1260962550701501447.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <27ba42ac-ec08-fd9c-dee2-53414eb0bc58@oracle.com>
Date:   Tue, 24 Mar 2020 16:27:44 +0000
MIME-Version: 1.0
In-Reply-To: <158500774067.2088294.1260962550701501447.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=5 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=5 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003240087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/20 11:55 PM, Dan Williams wrote:
> In support of interrogating the physical address layout of a device with
> dis-contiguous ranges, introduce a sysfs directory with 'start', 'end',
> and 'page_offset' attributes. The alternative is trying to parse
> /proc/iomem, and that file will not reflect the extent layout until the
> device is enabled.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/dax/bus.c         |  190 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dax/dax-private.h |   14 +++
>  2 files changed, 202 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 07aeb8fa9ee8..645449a079bd 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -558,6 +558,167 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
>  }
>  EXPORT_SYMBOL_GPL(alloc_dax_region);
>  
> +static void dax_mapping_release(struct device *dev)
> +{
> +	struct dax_mapping *mapping = to_dax_mapping(dev);
> +	struct dev_dax *dev_dax = to_dev_dax(dev->parent);
> +
> +	ida_free(&dev_dax->ida, mapping->id);
> +	kfree(mapping);
> +}
> +
> +static void unregister_dax_mapping(void *data)
> +{
> +	struct device *dev = data;
> +	struct dax_mapping *mapping = to_dax_mapping(dev);
> +	struct dev_dax *dev_dax = to_dev_dax(dev->parent);
> +	struct dax_region *dax_region = dev_dax->region;
> +
> +	dev_dbg(dev, "%s\n", __func__);
> +
> +	device_lock_assert(dax_region->dev);
> +
> +	dev_dax->ranges[mapping->range_id].mapping = NULL;
> +	mapping->range_id = -1;
> +
> +	device_del(dev);
> +	put_device(dev);
> +}
> +
> +static struct dev_dax_range *get_dax_range(struct device *dev)
> +{
> +	struct dax_mapping *mapping = to_dax_mapping(dev);
> +	struct dev_dax *dev_dax = to_dev_dax(dev->parent);
> +	struct dax_region *dax_region = dev_dax->region;
> +
> +	device_lock(dax_region->dev);
> +	if (mapping->range_id < 1) {
            ^^^^^^^^^^^^^^^^^^^^^ perhaps "mapping->range_id < 0" ?

AFAICT, invalid/disabled ranges have id to -1.

Otherwise we can't use mapping0 entry fields.

 Joao
