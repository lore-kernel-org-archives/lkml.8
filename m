Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A212C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2B420736
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ucJERNhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgDWRgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 13:36:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38004 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729858AbgDWRgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 13:36:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03NHSvpo187694;
        Thu, 23 Apr 2020 17:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=3S9ajz9TJAapFD3cdc1EsovmQ50Uk8rdsK/sJjag/DE=;
 b=ucJERNhRM2ZJgr3l5XlpwGNw1Y5KTgmHDDERWOcFoUzcbCwjtab81MpCp81fuZE9mYa+
 /lyaBYVMCrIF35An0w3Ot05LzosJ7X+gMAosGFMdKUtSBeCuv8i+XBdtRr+JiyOOwbPI
 HbALG/FbXj/jzuyVTh8DCcRVo4EIokBH6hWXIynyLJCiUgL2/zXEo+/Vy8cOW4NSJdeL
 gHp4dqhP6g4Op0ZrFUFR4NOUuwtgwqcs/nZdZGOVnidzqj5qZZwm1CXdSgHmJU2xYryx
 lEpXC5xQtMucxZGi2w8Gpg5E71G8rz+VCd3v/zK9e+Hz+OoM6h159dtdMsftVjfUhBG+ kw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30k7qe2qrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 17:35:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03NHRZPD046952;
        Thu, 23 Apr 2020 17:35:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30k7qvha97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 17:35:41 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03NHZbud024696;
        Thu, 23 Apr 2020 17:35:37 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Apr 2020 10:35:36 -0700
Date:   Thu, 23 Apr 2020 20:35:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vesa =?iso-8859-1?B?SuTkc2tlbORpbmVu?= 
        <vesa.jaaskelainen@vaisala.com>
Cc:     op-tee@lists.trustedfirmware.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Hongbo Yao <yaohongbo@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] tee: add support for session's client UUID generation
Message-ID: <20200423173527.GP2682@kadam>
References: <20200423151701.111231-1-vesa.jaaskelainen@vaisala.com>
 <20200423151701.111231-2-vesa.jaaskelainen@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200423151701.111231-2-vesa.jaaskelainen@vaisala.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=2 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=2 mlxlogscore=999 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 06:16:59PM +0300, Vesa Jääskeläinen wrote:
> +static int uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
> +		   size_t size)
> +{
> +	unsigned char hash[SHA1_DIGEST_SIZE];
> +	struct crypto_shash *shash = NULL;
> +	struct shash_desc *desc = NULL;
> +	int rc;
> +
> +	shash = crypto_alloc_shash("sha1", 0, 0);
> +	if (IS_ERR(shash)) {
> +		rc = PTR_ERR(shash);
> +		pr_err("shash(sha1) allocation failed\n");
> +		return rc;
> +	}
> +
> +	desc = kzalloc(sizeof(*desc) + crypto_shash_descsize(shash),
> +		       GFP_KERNEL);
> +	if (IS_ERR(desc)) {


kzalloc() returns NULL on error.

> +		rc = PTR_ERR(desc);
> +		goto out;

Please choose a label name so that we can tell what the goto will do
like "goto free_shash;".

> +	}
> +
> +	desc->tfm = shash;
> +
> +	rc = crypto_shash_init(desc);
> +	if (rc < 0)
> +		goto out2;
> +
> +	rc = crypto_shash_update(desc, (const u8 *)ns, sizeof(*ns));
> +	if (rc < 0)
> +		goto out2;
> +
> +	rc = crypto_shash_update(desc, (const u8 *)name, size);
> +	if (rc < 0)
> +		goto out2;
> +
> +	rc = crypto_shash_final(desc, hash);
> +	if (rc < 0)
> +		goto out2;
> +
> +	memcpy(uuid->b, hash, UUID_SIZE);
> +
> +	/* Tag for version 5 */
> +	uuid->b[6] = (hash[6] & 0x0F) | 0x50;
> +	uuid->b[8] = (hash[8] & 0x3F) | 0x80;
> +
> +out2:
> +	kfree(desc);
> +
> +out:
> +	crypto_free_shash(shash);
> +	return rc;
> +}
> +
> +int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
> +				 const u8 connection_data[TEE_IOCTL_UUID_LEN])
> +{
> +	const char *application_id = NULL;
> +	gid_t ns_grp = (gid_t)-1;
> +	kgid_t grp = INVALID_GID;
> +	char *name = NULL;
> +	int rc;
> +
> +	if (connection_method == TEE_IOCTL_LOGIN_PUBLIC) {
> +		/* Nil UUID to be passed to TEE environment */
> +		uuid_copy(uuid, &uuid_null);
> +		return 0;
> +	}
> +
> +	/*
> +	 * In Linux environment client UUID is based on UUIDv5.
> +	 *
> +	 * Determine client UUID with following semantics for 'name':
> +	 *
> +	 * For TEEC_LOGIN_USER:
> +	 * uid=<uid>
> +	 *
> +	 * For TEEC_LOGIN_GROUP:
> +	 * gid=<gid>
> +	 *
> +	 */
> +
> +	name = kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	switch (connection_method) {
> +	case TEE_IOCTL_LOGIN_USER:
> +		scnprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=%x",
> +			  current_euid().val);

It doesn't make sense to use sCnprintf() instead of snprintf() if we're
not going to preserve the error code.  Probably it's better to preserve
the error code actually so we can avoid the strlen(name) later on.

> +		break;
> +
> +	case TEE_IOCTL_LOGIN_GROUP:
> +		memcpy(&ns_grp, connection_data, sizeof(gid_t));
> +		grp = make_kgid(current_user_ns(), ns_grp);
> +		if (!gid_valid(grp) || !in_egroup_p(grp)) {
> +			rc = -EPERM;
> +			goto out;
> +		}
> +
> +		scnprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=%x", grp.val);
> +		break;
> +
> +	default:
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	rc = uuid_v5(uuid, &tee_client_uuid_ns, name, strlen(name));
> +out:
> +	kfree(name);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(tee_session_calc_client_uuid);

regards,
dan carpenter

