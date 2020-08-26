Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E248DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C09032087C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Iq0h45Xc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgHZLDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:03:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44454 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbgHZK4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:56:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QAtwMF014853;
        Wed, 26 Aug 2020 10:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=g9Ql9sKmcEYsuER3aA9MoOtpclK3oCvPADM1Sl0EZ5c=;
 b=Iq0h45XcrSMxESEl7mL2pDKFSW0njbDi5OKqiJ4QxJJ7k10ArJ6sXk78xGlHa7PmoXQ5
 xYdXfgNt9CxD22NWdXzL8OZWhbAbNqXeQ9KpYlh1F55R+rkFORtnK6xg+gO62z7FgbPN
 6UYZCJ//KSjErhar1IyBXqZHevGmt2vGPstqVxklgBckf2giF2yTmASsmiA1JXbg25DN
 eNZJAO5Nt7HUUy3SbqXcDNSDLsgb9CPdqwhZaD9Gx7+rwgd/Kt8u8pb92O7dkhdMv/8y
 +XQ18jTzGicGLSDj2Ijh2HHN6kTCUjkX2+ZmJ4cQSYcjOh/3siDMZvT5+sFX6c5v/xVH ow== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 333dbrypaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Aug 2020 10:56:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QAjOuS038492;
        Wed, 26 Aug 2020 10:54:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 333r9kr8t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 10:54:18 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07QAsERw008522;
        Wed, 26 Aug 2020 10:54:14 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Aug 2020 03:54:13 -0700
Date:   Wed, 26 Aug 2020 13:54:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     FelixCuioc <FelixCui-oc@zhaoxin.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, kbuild@lists.01.org,
        kbuild-all@lists.01.org, CobeChen-oc@zhaoxin.com,
        RaymondPang-oc@zhaoxin.com, TonyWWang-oc@zhaoxin.com
Subject: Re: [PATCH 1/3] iommu/vt-d:Add support for detecting ACPI device in
 RMRR
Message-ID: <20200826105404.GZ5493@kadam>
References: <20200826102752.3776-1-FelixCui-oc@zhaoxin.com>
 <20200826102752.3776-2-FelixCui-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826102752.3776-2-FelixCui-oc@zhaoxin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 06:27:50AM -0400, FelixCuioc wrote:
> Some ACPI devices need to issue dma requests to access
> the reserved memory area.BIOS uses the device scope type
> ACPI_NAMESPACE_DEVICE in RMRR to report these ACPI devices.
> This patch add support for detecting ACPI devices in RMRR.
> 
> Signed-off-by: FelixCuioc <FelixCui-oc@zhaoxin.com>
> ---
>  drivers/iommu/intel/dmar.c  | 74 ++++++++++++++++++++-----------------
>  drivers/iommu/intel/iommu.c | 22 ++++++++++-
>  include/linux/dmar.h        | 12 +++++-
>  3 files changed, 72 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 93e6345f3414..024ca38dba12 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -215,7 +215,7 @@ static bool dmar_match_pci_path(struct dmar_pci_notify_info *info, int bus,
>  }
>  
>  /* Return: > 0 if match found, 0 if no match found, < 0 if error happens */
> -int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
> +int dmar_pci_insert_dev_scope(struct dmar_pci_notify_info *info,
>  			  void *start, void*end, u16 segment,
>  			  struct dmar_dev_scope *devices,
>  			  int devices_cnt)
> @@ -304,7 +304,7 @@ static int dmar_pci_bus_add_dev(struct dmar_pci_notify_info *info)
>  
>  		drhd = container_of(dmaru->hdr,
>  				    struct acpi_dmar_hardware_unit, header);
> -		ret = dmar_insert_dev_scope(info, (void *)(drhd + 1),
> +		ret = dmar_pci_insert_dev_scope(info, (void *)(drhd + 1),
>  				((void *)drhd) + drhd->header.length,
>  				dmaru->segment,
>  				dmaru->devices, dmaru->devices_cnt);
> @@ -696,48 +696,56 @@ dmar_find_matched_drhd_unit(struct pci_dev *dev)
>  
>  	return dmaru;
>  }
> -
> -static void __init dmar_acpi_insert_dev_scope(u8 device_number,
> -					      struct acpi_device *adev)
> +int dmar_acpi_insert_dev_scope(u8 device_number,

The patch deleted the blank line between functions.  Make this function
bool, change the 1/0 to true/false.  Add a comment explaining what the
return values mean.

> +				struct acpi_device *adev,
> +				void *start, void *end,
> +				struct dmar_dev_scope *devices,
> +				int devices_cnt)
>  {
> -	struct dmar_drhd_unit *dmaru;
> -	struct acpi_dmar_hardware_unit *drhd;
>  	struct acpi_dmar_device_scope *scope;
>  	struct device *tmp;
>  	int i;
>  	struct acpi_dmar_pci_path *path;
>  
> +	for (; start < end; start += scope->length) {
> +		scope = start;

Are we sure that there is enough space for sizeof(*scope) in end - start?
(I don't know this code so maybe we are).

> +		if (scope->entry_type != ACPI_DMAR_SCOPE_TYPE_NAMESPACE)
> +			continue;
> +		if (scope->enumeration_id != device_number)
> +			continue;
> +		path = (void *)(scope + 1);
> +		for_each_dev_scope(devices, devices_cnt, i, tmp)
> +			if (tmp == NULL) {
> +				devices[i].bus = scope->bus;
> +				devices[i].devfn = PCI_DEVFN(path->device, path->function);
> +				rcu_assign_pointer(devices[i].dev,
> +						   get_device(&adev->dev));
> +				return 1;
> +			}
> +		WARN_ON(i >= devices_cnt);
> +	}
> +	return 0;
> +}
> +static int dmar_acpi_bus_add_dev(u8 device_number, struct acpi_device *adev)
> +{
> +	struct dmar_drhd_unit *dmaru;
> +	struct acpi_dmar_hardware_unit *drhd;
> +	int ret = 0;

This initialization is never used.

> +
>  	for_each_drhd_unit(dmaru) {
>  		drhd = container_of(dmaru->hdr,
>  				    struct acpi_dmar_hardware_unit,
>  				    header);
> +		ret = dmar_acpi_insert_dev_scope(device_number, adev, (void *)(drhd+1),
> +						((void *)drhd)+drhd->header.length,
> +						dmaru->devices, dmaru->devices_cnt);
> +		if (ret)
> +			break;
> +	}
> +	ret = dmar_rmrr_add_acpi_dev(device_number, adev);

What about if dmar_acpi_insert_dev_scope() always returns zero, do we
still want to call dmar_rmrr_add_acpi_dev()?

>  
> -		for (scope = (void *)(drhd + 1);
> -		     (unsigned long)scope < ((unsigned long)drhd) + drhd->header.length;
> -		     scope = ((void *)scope) + scope->length) {
> -			if (scope->entry_type != ACPI_DMAR_SCOPE_TYPE_NAMESPACE)
> -				continue;
> -			if (scope->enumeration_id != device_number)
> -				continue;
> +	return ret;
>  
> -			path = (void *)(scope + 1);
> -			pr_info("ACPI device \"%s\" under DMAR at %llx as %02x:%02x.%d\n",
> -				dev_name(&adev->dev), dmaru->reg_base_addr,
> -				scope->bus, path->device, path->function);
> -			for_each_dev_scope(dmaru->devices, dmaru->devices_cnt, i, tmp)
> -				if (tmp == NULL) {
> -					dmaru->devices[i].bus = scope->bus;
> -					dmaru->devices[i].devfn = PCI_DEVFN(path->device,
> -									    path->function);
> -					rcu_assign_pointer(dmaru->devices[i].dev,
> -							   get_device(&adev->dev));
> -					return;
> -				}
> -			BUG_ON(i >= dmaru->devices_cnt);
> -		}
> -	}
> -	pr_warn("No IOMMU scope found for ANDD enumeration ID %d (%s)\n",
> -		device_number, dev_name(&adev->dev));
>  }
>  
>  static int __init dmar_acpi_dev_scope_init(void)
> @@ -766,7 +774,7 @@ static int __init dmar_acpi_dev_scope_init(void)
>  				       andd->device_name);
>  				continue;
>  			}
> -			dmar_acpi_insert_dev_scope(andd->device_number, adev);
> +			dmar_acpi_bus_add_dev(andd->device_number, adev);
>  		}
>  	}
>  	return 0;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index ca557d351518..f774ef63d473 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4507,6 +4507,24 @@ int dmar_find_matched_atsr_unit(struct pci_dev *dev)
>  
>  	return ret;
>  }
> +int dmar_rmrr_add_acpi_dev(u8 device_number, struct acpi_device *adev)

Please add a blank line between functions.
> +{
> +	int ret;
> +	struct dmar_rmrr_unit *rmrru;
> +	struct acpi_dmar_reserved_memory *rmrr;
> +
> +	list_for_each_entry(rmrru, &dmar_rmrr_units, list) {
> +		rmrr = container_of(rmrru->hdr,
> +				struct acpi_dmar_reserved_memory,
> +				header);
> +		ret = dmar_acpi_insert_dev_scope(device_number, adev, (void *)(rmrr + 1),
> +						((void *)rmrr) + rmrr->header.length,
> +						rmrru->devices, rmrru->devices_cnt);
> +		if (ret)
> +			break;
> +	}
> +	return 0;
> +}

regards,
dan carpenter

