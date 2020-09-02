Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFFCC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C98AE2078E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgIBMXn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 08:23:43 -0400
Received: from mail-oln040092072093.outbound.protection.outlook.com ([40.92.72.93]:15425
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726654AbgIBMXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 08:23:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lo1T2UJ8c6vfGIEboKxoKKtLGxyfTwlo1CNo/k0V4IuqZpCZ11QK5c4bWc43ajtAdt1TEyICyp3vw6ZYNPOAS64RmgCV1Xq/8I5TyoFqT6+KPaEMMCdWByaUOWp19Yu8D5iB+0Tl8s1kzbTHMyCztIJ2i6S8mt5AQeTjf7XjVwV5kbGHjevKPUYn7uvlnbTrK/KziuXDoZb6pp8EbrvjGYpNme6ePc1byLCzfGGt94Ys8pDNMDB3leVXxnQlh9r1e1dVOP4na0eV1ZLw/qKQZSIpNlEmRpwwuDhYDvmoUUDk1CucSrnKANXYGHJz4P9TnxF1dRGEtA2/W7Fb9ghEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6X9htJyq1/r/tMo+KBMXvV9D/OEyqtiRU3WUh8zUAw=;
 b=SY+NuSgJJs2wNeRwjrPIu2KQ2NFWxU/8VbIWlrmc4O4o7rdeAmQ/TJ3DdrcC7NtCjkdiEHW8+IwVpv5ZojhAQ6aXyX5KSRx9lhEDD5z8wI1bwdvCoe/BK2bz113YlxQ+EDYLSqMox8tFz1+1q5oEs4SfvF8retuHvc1pNfyYoPCUindVa8B3LIzfr2qfp54qiYDd/PG92NKZqtenhc9OIscFFVMPqVDzV779uJ0Qk0uYTCCkCukNuIqUfyxq1gSFCjHKlLh+baaEAHR4S9RuUMpc4RjSDMIqLWsrez+5fP+3EQfTG/vjnZcyZcOcM8Eu0eaUKafusPBlNz/Ghj0GNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
 (2a01:111:e400:7e0a::53) by
 DB5EUR03HT098.eop-EUR03.prod.protection.outlook.com (2a01:111:e400:7e0a::203)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Wed, 2 Sep
 2020 12:23:10 +0000
Received: from DB3PR0202MB3387.eurprd02.prod.outlook.com
 (2a01:111:e400:7e0a::50) by DB5EUR03FT034.mail.protection.outlook.com
 (2a01:111:e400:7e0a::87) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 2 Sep 2020 12:23:10 +0000
Received: from DB3PR0202MB3387.eurprd02.prod.outlook.com
 ([fe80::810f:b93:e0bf:f67c]) by DB3PR0202MB3387.eurprd02.prod.outlook.com
 ([fe80::810f:b93:e0bf:f67c%6]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 12:23:10 +0000
From:   Harley Paterson <harley.paterson@hotmail.co.nz>
To:     "christian@brauner.io" <christian@brauner.io>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] kernel/pid: Rename `find_ge_pid` to `find_get_vpid`.
Thread-Topic: [PATCH] kernel/pid: Rename `find_ge_pid` to `find_get_vpid`.
Thread-Index: AQHWgSOnDXzg6hoG0E2ayBn4/b/BhQ==
Date:   Wed, 2 Sep 2020 12:23:10 +0000
Message-ID: <DB3PR0202MB3387446FE969A6D39819D879F92F0@DB3PR0202MB3387.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:0955B82F9ED8C9D1B3B86CEFC892FE911F81573FF63303D559D986ED2884921F;UpperCasedChecksum:3C9F602A39D3ED403D6F32C871A70591B8D6EAE1BBB4C2599BC4942B68159465;SizeAsReceived:6803;Count:43
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [LbUlvp4qr9E82WZNJmM46LhZBIEvw82D]
x-ms-publictraffictype: Email
x-incomingheadercount: 43
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: ed830178-5e1f-4f28-f16b-08d84f3af4e5
x-ms-traffictypediagnostic: DB5EUR03HT098:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VJ3zQLDD0ezvzcDduWuAdubS4uHxGDs8Ud0kE1dvMEukBMhQ6gc3+Bcb3+TkQ65c2UFuheVWXZ+b6Sm+5xjFLX7026xlZL7hEsPTHw+aQvT2Ig+n8vwsLiKG7koar+rc7xCeh0f+nh/bgFLKpjVK+cO53f+4sgPW8FfEbjMUVdjuojvq7SFemJTvTzw5aX8cp1apa6qPP6kgiasOmFy9wg==
x-ms-exchange-antispam-messagedata: BLG1C72kHx0JlQ+qM8ITOqUhmifFYiyY+QaTwVn32Du05KYhrlEIb0UQoZZKex7g3gmZeCyCvbaDLV79/eoNZ07TFyPABVF4QoZ0QkQZWQAkxNv6GYxaBDvjnkh+VlIFb54NjmP0wB7sB7FlrxBilg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ed830178-5e1f-4f28-f16b-08d84f3af4e5
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 12:23:10.7273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR03HT098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most PID functions in `kernel/pid.c` are named in the format
[do_something]_pid, and functions with a VPID counterpart have
the corresponding name [do_something]_vpid.

`find_get_pid` and its VPID counterpart, `find_ge_pid` do not share
this convention.

This patch renames `find_ge_pid` to `find_get_vpid` to conform to the
existing PID function naming idioms. I believe the proposed name
makes the purpose of the function clearer.

I have built and tested this patch on an x64 virtual machine, running
Ubuntu 20.04 LTS. My tests involved building the modified kernel,
installing it, and booting into a Ubuntu GUI session.

This patch is applied on top of the linux-5.9-rc3 kernel

This patch effects four lines, one in each of four files.

Signed-off-by: H Paterson <harley.paterson@hotmail.co.nz>
---
 fs/proc/base.c         | 2 +-
 include/linux/pid.h    | 2 +-
 kernel/bpf/task_iter.c | 2 +-
 kernel/pid.c           | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 617db4e0f..e2ff20311 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3390,7 +3390,7 @@ static struct tgid_iter next_tgid(struct pid_namespace *ns, struct tgid_iter ite
 	rcu_read_lock();
 retry:
 	iter.task = NULL;
-	pid = find_ge_pid(iter.tgid, ns);
+	pid = find_get_vpid(iter.tgid, ns);
 	if (pid) {
 		iter.tgid = pid_nr_ns(pid, ns);
 		iter.task = pid_task(pid, PIDTYPE_TGID);
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 176d6cf80..2875b4189 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -128,7 +128,7 @@ extern struct pid *find_vpid(int nr);
  * Lookup a PID in the hash table, and return with it's count elevated.
  */
 extern struct pid *find_get_pid(int nr);
-extern struct pid *find_ge_pid(int nr, struct pid_namespace *);
+extern struct pid *find_get_vpid(int nr, struct pid_namespace *);
 
 extern struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 			     size_t set_tid_size);
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 99af4cea1..334cb8831 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -29,7 +29,7 @@ static struct task_struct *task_seq_get_next(struct pid_namespace *ns,
 
 	rcu_read_lock();
 retry:
-	pid = find_ge_pid(*tid, ns);
+	pid = find_get_vpid(*tid, ns);
 	if (pid) {
 		*tid = pid_nr_ns(pid, ns);
 		task = get_pid_task(pid, PIDTYPE_PID);
diff --git a/kernel/pid.c b/kernel/pid.c
index b2562a7ce..0c77fef72 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -514,7 +514,7 @@ EXPORT_SYMBOL_GPL(task_active_pid_ns);
  *
  * If there is a pid at nr this function is exactly the same as find_pid_ns.
  */
-struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
+struct pid *find_get_vpid(int nr, struct pid_namespace *ns)
 {
 	return idr_get_next(&ns->idr, &nr);
 }
-- 
2.25.1

