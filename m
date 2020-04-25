Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C981C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 09:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D306E2074F
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 09:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lrZti5QB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgDYJZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 05:25:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57216 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDYJZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 05:25:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03P9N63I172295;
        Sat, 25 Apr 2020 09:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=E4qYxCnU4PYfmFZxSvJ3HLmvAuXno1o/zIOiRjeOkwA=;
 b=lrZti5QBahzHZKup8JYThKloqQnP953PVbwItHZDzEq8l6Dys10aCZ1JpjpOrZQwB6Ky
 m/F5VuVJ1IB1eWQcYYuhDnrYd9+N6loSlYTV/qHSlgEkzVG25lps3AJPC/AcUIIL+rq+
 ZaPHo6rbaFpJLI+o9/7Ir3gOCuqInOAkSBzQGqT7nBsylU0jTyG8SRNYWbJvfLD9oSuV
 PnkaQGg0Ypwtll+UBpWMICVF0C8aYQ+7doXFD3z3+Ie0S3fJn4oJGEwQZGJDYKsioD61
 Bf4WxOMekwVpNsS76laPFAEAO4w8N9jYq+77KIo5QWtCyVuxGLm+J1rjCcmCKOhOf7rf FA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30mdumrj0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Apr 2020 09:24:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03P9MRkI134537;
        Sat, 25 Apr 2020 09:24:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30maarw53a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Apr 2020 09:24:50 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03P9Okj3002586;
        Sat, 25 Apr 2020 09:24:47 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 25 Apr 2020 02:24:46 -0700
Date:   Sat, 25 Apr 2020 12:24:39 +0300
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
Message-ID: <20200425092439.GT2682@kadam>
References: <20200423151701.111231-1-vesa.jaaskelainen@vaisala.com>
 <20200423151701.111231-2-vesa.jaaskelainen@vaisala.com>
 <20200423173527.GP2682@kadam>
 <29b76307-12cb-c52e-f72f-eb7c22bab012@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29b76307-12cb-c52e-f72f-eb7c22bab012@vaisala.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9601 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004250080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9601 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004250080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 09:16:57AM +0300, Vesa Jääskeläinen wrote:
> Hi Dan,
> 
> Thanks for comments!
> 
> On 2020-04-23 20:35, Dan Carpenter wrote:
> > On Thu, Apr 23, 2020 at 06:16:59PM +0300, Vesa Jääskeläinen wrote:
> > > +static int uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
> > > +		   size_t size)
> > > +{
> > > +	unsigned char hash[SHA1_DIGEST_SIZE];
> > > +	struct crypto_shash *shash = NULL;
> > > +	struct shash_desc *desc = NULL;
> > > +	int rc;
> > > +
> > > +	shash = crypto_alloc_shash("sha1", 0, 0);
> > > +	if (IS_ERR(shash)) {
> > > +		rc = PTR_ERR(shash);
> > > +		pr_err("shash(sha1) allocation failed\n");
> > > +		return rc;
> > > +	}
> > > +
> > > +	desc = kzalloc(sizeof(*desc) + crypto_shash_descsize(shash),
> > > +		       GFP_KERNEL);
> > > +	if (IS_ERR(desc)) {
> > 
> > 
> > kzalloc() returns NULL on error.
> 
> Err...Right. Will fix for V2. Thanks for noticing this.
> 
> I was probably confused by this:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/slab.h?h=v5.7-rc2#n553
> 
> As there is no error handling case documented for kmalloc and friends -- I
> was just looking that as there are non-zero error cases in that referenced
> line (ZERO_SIZE_PTR) so we need to check if pointer has error value as it
> was with crypto_alloc_shash().
> 
> But looking at users of kzalloc then convention seems to be just check for
> NULL.
> 
> Probably referenced code is then expected to cause page fault on error case
> as ZERO_SIZE_PTR is not error value as such.


Zero size buffers are not an error.  You can copy zero bytes to them or
from them without a problem.

	size = 0;
	p = kmalloc(size, GFP_KERNEL);
	memcpy(p, src, 0);
	for (i = 0; i < size; i++)
		printk("%d\n", p[i]);
	copy_to_user(user_ptr, p, size);

All that's fine and does nothing.  You should never test for
ZERO_SIZE_PTR.  Check for "size == 0" instead.

> 
> > 
> > > +		rc = PTR_ERR(desc);
> > > +		goto out;
> > 
> > Please choose a label name so that we can tell what the goto will do
> > like "goto free_shash;".
> 
> Ok. Will update for V2.
> 
> > > +	}
> > > +
> > > +	desc->tfm = shash;
> > > +
> > > +	rc = crypto_shash_init(desc);
> > > +	if (rc < 0)
> > > +		goto out2;
> > > +
> > > +	rc = crypto_shash_update(desc, (const u8 *)ns, sizeof(*ns));
> > > +	if (rc < 0)
> > > +		goto out2;
> > > +
> > > +	rc = crypto_shash_update(desc, (const u8 *)name, size);
> > > +	if (rc < 0)
> > > +		goto out2;
> > > +
> > > +	rc = crypto_shash_final(desc, hash);
> > > +	if (rc < 0)
> > > +		goto out2;
> > > +
> > > +	memcpy(uuid->b, hash, UUID_SIZE);
> > > +
> > > +	/* Tag for version 5 */
> > > +	uuid->b[6] = (hash[6] & 0x0F) | 0x50;
> > > +	uuid->b[8] = (hash[8] & 0x3F) | 0x80;
> > > +
> > > +out2:
> > > +	kfree(desc);
> > > +
> > > +out:
> > > +	crypto_free_shash(shash);
> > > +	return rc;
> > > +}
> > > +
> > > +int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
> > > +				 const u8 connection_data[TEE_IOCTL_UUID_LEN])
> > > +{
> > > +	const char *application_id = NULL;
> > > +	gid_t ns_grp = (gid_t)-1;
> > > +	kgid_t grp = INVALID_GID;
> > > +	char *name = NULL;
> > > +	int rc;
> > > +
> > > +	if (connection_method == TEE_IOCTL_LOGIN_PUBLIC) {
> > > +		/* Nil UUID to be passed to TEE environment */
> > > +		uuid_copy(uuid, &uuid_null);
> > > +		return 0;
> > > +	}
> > > +
> > > +	/*
> > > +	 * In Linux environment client UUID is based on UUIDv5.
> > > +	 *
> > > +	 * Determine client UUID with following semantics for 'name':
> > > +	 *
> > > +	 * For TEEC_LOGIN_USER:
> > > +	 * uid=<uid>
> > > +	 *
> > > +	 * For TEEC_LOGIN_GROUP:
> > > +	 * gid=<gid>
> > > +	 *
> > > +	 */
> > > +
> > > +	name = kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);
> > > +	if (!name)
> > > +		return -ENOMEM;
> > > +
> > > +	switch (connection_method) {
> > > +	case TEE_IOCTL_LOGIN_USER:
> > > +		scnprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=%x",
> > > +			  current_euid().val);
> > 
> > It doesn't make sense to use sCnprintf() instead of snprintf() if we're
> > not going to preserve the error code.  Probably it's better to preserve
> > the error code actually so we can avoid the strlen(name) later on.
> 
> Ok. I assume you meant here using snprintf where we can capture the error
> situation of too large output string. scnprintf does not seem to have error
> returning capabilities.
> 
> I assume you meant something like this:
> 
> name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=%x",
> 		    current_euid().val);
> if (name_len >= TEE_UUID_NS_NAME_SIZE) {
> 	rc = -E2BIG;
> 	goto out_free_name;
> }
> 

None of the kernel snprintf() functions return negative error codes.
The difference between snprintf() and scnprintf() is that snprintf()
returns the number of bytes that would have been copied if there were
enough space and scnprintf() returns the number of bytes which were
*actually* copied.

But if we don't care about the return code, then we should default to
using snprintf() because it is the simpler looking function.  Always
right the simplest code you can.

regards,
dan carpenter

