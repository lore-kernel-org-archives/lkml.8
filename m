Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F767C55186
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 06:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08D5D2071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 06:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="tGbOzwKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgDYGRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 02:17:13 -0400
Received: from mail-vi1eur05on2047.outbound.protection.outlook.com ([40.107.21.47]:53600
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbgDYGRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 02:17:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQFMkFF4aKDAX2lPI6Rv5jvwDhKGG9isSzNuO38RTJWWZ1CMcq0GbbU6qag89+2ftt5ywawqBhVIpia2czctPEqqC8j4ktXXFIeg89mialospQhdrc5avPGXisQ0Je8UR3ZhSvwDc3qiyurdRJuZGVDzrsvhl09AylpU7sGei+gtwj7EcDbwDMtepa812gErdGjZh4XcBtQq1h/8U8V7F4hDUPQnWzC0A6Dg7J6skSVHhQ4vRFLGIawqOC0uPMucFB3bucqxQEJvZZszS11vk9inHRd3HZBlrE3eRWGWe2Atl0p4/MbfyqO04+R0IaDWIXX13JSkJjpeWwytpMYihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A8lYBqj7W1bh4XSlmfzRnD7ma0/X6kKRYvS28EQ/ec=;
 b=RQ0ZeYHjSXUOlMUCiFu5L+MjyAw8KHRqYJzMTYZXlkkRbirI51qICJrFcDBVRdu5S0GdIhLWV+iLS83oQPoml9oYFh5REuYPT+vojS6FbaBP0rkhPCtZvO2YmbleG/P3wFiw8OT4S/qmK38XsFkIOQMbS6rqkU+ZTVEFcCTH1s6FDogOq5yZaLoVi0wAeOKDRTQjpn2tb52PS5Q45tbEEeB0gXGYyZG2I+x6OGJ/kJPA1cmFbWHWGqLxfgVxM9t2jNHzmy2uvw+XXRmH1UV6BCsVZVzdJ5my+HS4meRGCudio49Pwc7LthCJ73OjcGe3QZ4tB59uESQsE8rVCb7DkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A8lYBqj7W1bh4XSlmfzRnD7ma0/X6kKRYvS28EQ/ec=;
 b=tGbOzwKImwQdjN8IIA+MN3zJO7YT1mVVbCgFPZt0iPDB1ARX5hpv+nX/9zBdCjvO4xOlZ4rtA67fzllTLqgUl6PU+bbcW9D0w2Wyv1DFBPAeB3PDUeGluG3WxW7eYKQgET7c3+hQIOvyhTj6gJtEXfCutei2rFLtpyrHKb3ZutQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vesa.jaaskelainen@vaisala.com; 
Received: from HE1PR0601MB2251.eurprd06.prod.outlook.com (2603:10a6:3:98::19)
 by HE1PR0601MB2425.eurprd06.prod.outlook.com (2603:10a6:3:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Sat, 25 Apr
 2020 06:17:07 +0000
Received: from HE1PR0601MB2251.eurprd06.prod.outlook.com
 ([fe80::68d4:f0e3:f0aa:d0eb]) by HE1PR0601MB2251.eurprd06.prod.outlook.com
 ([fe80::68d4:f0e3:f0aa:d0eb%7]) with mapi id 15.20.2921.036; Sat, 25 Apr 2020
 06:17:07 +0000
Subject: Re: [PATCH 1/3] tee: add support for session's client UUID generation
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     op-tee@lists.trustedfirmware.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Hongbo Yao <yaohongbo@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20200423151701.111231-1-vesa.jaaskelainen@vaisala.com>
 <20200423151701.111231-2-vesa.jaaskelainen@vaisala.com>
 <20200423173527.GP2682@kadam>
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= 
        <vesa.jaaskelainen@vaisala.com>
Message-ID: <29b76307-12cb-c52e-f72f-eb7c22bab012@vaisala.com>
Date:   Sat, 25 Apr 2020 09:16:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <20200423173527.GP2682@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0101CA0076.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::44) To HE1PR0601MB2251.eurprd06.prod.outlook.com
 (2603:10a6:3:98::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.196] (87.100.247.140) by AM4PR0101CA0076.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Sat, 25 Apr 2020 06:17:06 +0000
X-Originating-IP: [87.100.247.140]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fcf8f5a-bcbc-4970-5818-08d7e8e047d6
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2425:
X-Microsoft-Antispam-PRVS: <HE1PR0601MB2425874B7579777F59AE1022EDD10@HE1PR0601MB2425.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0384275935
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0601MB2251.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39850400004)(376002)(346002)(396003)(366004)(136003)(54906003)(16526019)(26005)(4326008)(8676002)(6916009)(86362001)(6666004)(2616005)(31686004)(5660300002)(2906002)(66556008)(956004)(36756003)(66476007)(66946007)(186003)(478600001)(31696002)(81156014)(85182001)(16576012)(966005)(85202003)(8936002)(53546011)(6486002)(66574012)(52116002)(316002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: vaisala.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t538P8UjA9F0BC/8yo+TtHnqDhvKxwWyNPIC0IWYN0bB2pBB701ctMeG53RsFyVVdZYKIkT4Yyhs1nZCA+K/ajbxJoTQUpsxkCWaDOHm4YgCFk62C6kJJxJ2QYh4tuuybi1xIhFhVwDZGkFUDD9M+rzN5EmjiTGdIuK9HsThwWqUz16p6ZEjvoPxpLZGlwW19hbAdDTy8p4sDUurZn2RSZN1N2cfdyKfOYCUTSk9DXqb07qzjMlmyKZNJlOmltl3EFrMA5lpDfz1wa6Pg8WjTaiKW5DJcivuW9nev5UCbrTZgyxV+BvHmsgk0YModiAQGm2qOLeDfqi1HiIbRut2Xbsp/5906+5JG5Ugwcp2mdbytbm/Yd7zbkp03HF9vDNAMG45pfyaoQZ43jGqoPxEGMsoiLQly+ssR/IzkRKHu7KsuOUFMXmr7QbnwVBDyeE0T1tzgDROjhaeTT4SXpqHvREEMudjRL765MMTk8KFmo4YEBI6x9lFv9qaqEyQN64LtELtCpHqPJM/yXvCodDy0Q==
X-MS-Exchange-AntiSpam-MessageData: PVloeim3EfGlrCqlz4xbaFrbxFSafwqiwsc2P0qjUm0WRNozWom3z8ohGGbcw7erg08DfFMU/dSSJ58mTl1vDZ/5+Q4X1RJpYWbch03NQ2gcz++TyWUvPNO3STWDHTmaKmQcAAkI5YVqXXdFZHZcjkAQgelRXPr8IxqNtQ3p27roA70ebXpk+v2owOY8n6T10GA7mBrmRM40pOiWLcvAWD9aiZB1Ek5VbhAL/J5/B+rXuafoG7HTnTVVTv7Ewl8unpC2KODPp1zIdatlOCJ9Zst0Xw1ygcSSdGYaXWEu36JFYH9WcjqBwXjDU4VrdvdnlcjxmleK1gitWzjtPbeDxOKerkjKisTwbg26PyM3TW2xZD0jCpcllhQ9+oNeDuUSrlK+6Zx/hh0sp8ltEFv73jg+ulNoIZmnZGhu0V4Bf7BwnyMSP/RMQCIpLNU9c0c2g6UGA94hp2F7swwITC/+kTiVtNUMCDo/A1v0qRca8TbszV0YdDwPhBEi672erbcqomAo62Y5O7svR1rf887A5YYRew0aZ3l2ptjpp+aCqZWkCdQk1YKpg7ZrgXP/vx9hzIYe7Xj02m9W+MLlzK8jRmcaLLNRQlfy34NScd0z7yoPWA/VJ/EjYxLspPNGD8lI381iaSRefBECYdlnpwNZ4/QRuKyCGeN1lRt/BK6cA1l4MMn3nEqbqEU8WqDc4yvJtn3ygbjVf4RAqZWRJqJ5I8HZe2lQPHBWCoZFu0qcjoVlL84MYGHxUYmE3cuIkOvZQdHrJfzR5kh/gcOZPfOlh1MsIqY5XT4V2S4d0YSXRVM=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcf8f5a-bcbc-4970-5818-08d7e8e047d6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2020 06:17:07.3801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqIJWnltcfaEJewUSb4oRzByO4RzXwlikNxVpmah2lDx4ig2Pert8hE1Tt3ZEkNA/c3K8/GNIHiQfySzMfwl/jEOBo7+FFK3Jl/F72yirQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2425
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thanks for comments!

On 2020-04-23 20:35, Dan Carpenter wrote:
> On Thu, Apr 23, 2020 at 06:16:59PM +0300, Vesa Jääskeläinen wrote:
>> +static int uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
>> +		   size_t size)
>> +{
>> +	unsigned char hash[SHA1_DIGEST_SIZE];
>> +	struct crypto_shash *shash = NULL;
>> +	struct shash_desc *desc = NULL;
>> +	int rc;
>> +
>> +	shash = crypto_alloc_shash("sha1", 0, 0);
>> +	if (IS_ERR(shash)) {
>> +		rc = PTR_ERR(shash);
>> +		pr_err("shash(sha1) allocation failed\n");
>> +		return rc;
>> +	}
>> +
>> +	desc = kzalloc(sizeof(*desc) + crypto_shash_descsize(shash),
>> +		       GFP_KERNEL);
>> +	if (IS_ERR(desc)) {
> 
> 
> kzalloc() returns NULL on error.

Err...Right. Will fix for V2. Thanks for noticing this.

I was probably confused by this:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/slab.h?h=v5.7-rc2#n553

As there is no error handling case documented for kmalloc and friends -- 
I was just looking that as there are non-zero error cases in that 
referenced line (ZERO_SIZE_PTR) so we need to check if pointer has error 
value as it was with crypto_alloc_shash().

But looking at users of kzalloc then convention seems to be just check 
for NULL.

Probably referenced code is then expected to cause page fault on error 
case as ZERO_SIZE_PTR is not error value as such.

> 
>> +		rc = PTR_ERR(desc);
>> +		goto out;
> 
> Please choose a label name so that we can tell what the goto will do
> like "goto free_shash;".

Ok. Will update for V2.

>> +	}
>> +
>> +	desc->tfm = shash;
>> +
>> +	rc = crypto_shash_init(desc);
>> +	if (rc < 0)
>> +		goto out2;
>> +
>> +	rc = crypto_shash_update(desc, (const u8 *)ns, sizeof(*ns));
>> +	if (rc < 0)
>> +		goto out2;
>> +
>> +	rc = crypto_shash_update(desc, (const u8 *)name, size);
>> +	if (rc < 0)
>> +		goto out2;
>> +
>> +	rc = crypto_shash_final(desc, hash);
>> +	if (rc < 0)
>> +		goto out2;
>> +
>> +	memcpy(uuid->b, hash, UUID_SIZE);
>> +
>> +	/* Tag for version 5 */
>> +	uuid->b[6] = (hash[6] & 0x0F) | 0x50;
>> +	uuid->b[8] = (hash[8] & 0x3F) | 0x80;
>> +
>> +out2:
>> +	kfree(desc);
>> +
>> +out:
>> +	crypto_free_shash(shash);
>> +	return rc;
>> +}
>> +
>> +int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>> +				 const u8 connection_data[TEE_IOCTL_UUID_LEN])
>> +{
>> +	const char *application_id = NULL;
>> +	gid_t ns_grp = (gid_t)-1;
>> +	kgid_t grp = INVALID_GID;
>> +	char *name = NULL;
>> +	int rc;
>> +
>> +	if (connection_method == TEE_IOCTL_LOGIN_PUBLIC) {
>> +		/* Nil UUID to be passed to TEE environment */
>> +		uuid_copy(uuid, &uuid_null);
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * In Linux environment client UUID is based on UUIDv5.
>> +	 *
>> +	 * Determine client UUID with following semantics for 'name':
>> +	 *
>> +	 * For TEEC_LOGIN_USER:
>> +	 * uid=<uid>
>> +	 *
>> +	 * For TEEC_LOGIN_GROUP:
>> +	 * gid=<gid>
>> +	 *
>> +	 */
>> +
>> +	name = kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);
>> +	if (!name)
>> +		return -ENOMEM;
>> +
>> +	switch (connection_method) {
>> +	case TEE_IOCTL_LOGIN_USER:
>> +		scnprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=%x",
>> +			  current_euid().val);
> 
> It doesn't make sense to use sCnprintf() instead of snprintf() if we're
> not going to preserve the error code.  Probably it's better to preserve
> the error code actually so we can avoid the strlen(name) later on.

Ok. I assume you meant here using snprintf where we can capture the 
error situation of too large output string. scnprintf does not seem to 
have error returning capabilities.

I assume you meant something like this:

name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=%x",
		    current_euid().val);
if (name_len >= TEE_UUID_NS_NAME_SIZE) {
	rc = -E2BIG;
	goto out_free_name;
}

Will wait a bit more for comments before sending V2.

I already updated my devel branch with these for those wanting to play 
around with the updates:
https://github.com/vesajaaskelainen/linux/commits/optee-login-checks

Thanks,
Vesa Jääskeläinen
