Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1C9C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C63B22522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="eQf8dvl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgAUKk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:40:29 -0500
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:19078
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728803AbgAUKk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:40:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbvdSE+rnbjaiQ/wE+qo6lg0WD1885f3XwxSwYeJSA7Ic3aeHU02lzP1diKbwTWOzFUgu/BW+Nsq9Ih5wFDiqWydgC5N4hqj3iDj6FqRdj0g5eDtaWusmYyJKt3ELN6MpLVk5yHnr0hwbYKibTpAnfp/lL7Ma1jioX58MREmTDeoHxjv3eH+F0vAFcLGjM48EKfEhZf5fO4Vda0cH07AdINVEWEaq7gBSR3+D5uxy8iRrk7A/js9CJd8leNdRLZROo+m2LzkYYhm1qoVkbtqiTG9us3atfoAollMR0NKB9AioafWRBwDb+azJzZhobjHymdTuVA8d4eqSTFq2+TayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKPefbO3hbTshMXXs+9maxl54Qi6RTtDp/R303c1pkM=;
 b=Adv8bj6hgaCINOMaqpAu+GQXqHSUniQMPO1sb2yUs/GEQB1jqAtAT9ZN2q8l/iILYEJ/ouSiTJ+x/cTeFMJAQu/wVZ8d0tGydZQKsi2kjzXoa4EvHwGP1Z3JYax6cq0qvg8+Ii/xUzZiBU7MBv6RtHtL3yb9F8+D8Docy5EmiKpEPxRkCFS3Y6AI3sn+aW2mGJpimwkOnqxq9kqKjYaDuddQjVznXB6hHAL527z7+aQHpLqKnTCGBk7lx9Pt87S3BGfro608OEN+wv/QuIxHN7oJL+/MQamJgSTuRcOwNI5AFueEd7RVSHr+SBEGLYPngpi/SkKrbuCNQNQ+pRZ/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=itdev.co.uk; dmarc=pass action=none header.from=itdev.co.uk;
 dkim=pass header.d=itdev.co.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector2-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKPefbO3hbTshMXXs+9maxl54Qi6RTtDp/R303c1pkM=;
 b=eQf8dvl6DUgSQI9fOdancba+Sm6sK9kljyC7ho570jEB53xNECtYbLFcm83oSixgMdHIYVPw7M7kd1FsfkwrWfykTvMpXq0dwNi4dJnfItJtrE1z2T3sOvWLkkf06n9KKqgHo2su951lRH2vGSqGvP3QfuCwTmaSgnOGSVSdewk=
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com (20.179.44.144) by
 DBBPR08MB4790.eurprd08.prod.outlook.com (10.255.79.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Tue, 21 Jan 2020 10:40:24 +0000
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::11b4:6ffd:de3:a862]) by DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::11b4:6ffd:de3:a862%5]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 10:40:24 +0000
Received: from jiffies.local.naccyde.eu (54.37.17.75) by LO2P265CA0395.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:f::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Tue, 21 Jan 2020 10:40:24 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: axis-fifo: replace spinlock with mutex
Thread-Topic: [PATCH] staging: axis-fifo: replace spinlock with mutex
Thread-Index: AQHV0EcwztXaeqo5U0uNCBIh5KhweA==
Date:   Tue, 21 Jan 2020 10:40:24 +0000
Message-ID: <20200121103958.12941-1-quentin.deslandes@itdev.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0395.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::23) To DBBPR08MB4491.eurprd08.prod.outlook.com
 (2603:10a6:10:d2::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.24.1
x-originating-ip: [54.37.17.75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87747d70-8f13-4012-0c35-08d79e5e5280
x-ms-traffictypediagnostic: DBBPR08MB4790:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR08MB4790E44B865897DFFA894CFFB30D0@DBBPR08MB4790.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39830400003)(396003)(376002)(346002)(199004)(189003)(66556008)(66476007)(26005)(16526019)(71200400001)(316002)(44832011)(64756008)(66946007)(66446008)(2906002)(186003)(5660300002)(86362001)(6506007)(508600001)(8936002)(2616005)(110136005)(8676002)(36756003)(956004)(81166006)(81156014)(6512007)(55236004)(6486002)(52116002)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4790;H:DBBPR08MB4491.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0B+51rYLiws6V5ReJ6hLhwc5sbAKOrGchgNxI3gElRss0XknCN+7ydwusR14gKDOmuYvx6NqiLn4lK9RBFba9XwdshFVtbtaa/ksaU1ThS44pDC0h0RJ2T0F8vGBvtpUtHUkUApy7XwJchv737tANTeP69ySd8EOFEehrNLnk/csA9E7yqlcM5hrtvHOf9P6535y0vjQhQETyI5eKAKfBl+jOKG8tXqKoaTBXpVVCxqfsI9nhfgDsPn6WOj5CneV5zSMZLJvttHX+usD/7As3ojkmjve5yrKRvJT5c/pev8sfTJtePHb3GpLNqxgDm9+1MkXAAh2l+ub/BxtRjvUPkEJeqxlsj1aMHIupw39snbt5rnLLUy6mDCuWzbpoFeNCfojnuMdC1ojiCLWuHgwb7h4A1ByvordAjt6DBLhyP1+++9TuQXbeZybMhZ8pGzP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 87747d70-8f13-4012-0c35-08d79e5e5280
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 10:40:24.6441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xGQjtQVXE95TjabiroV4st7ggKfWXxuMDhH3cbNMccKp/NKKLkxmjx3CzZgxtR6wYNOFqLaWGbsTEGYXNfDS//xeHSoVYG7i9801jWAIqgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the device's documentation guidance, reading a packet from the
device or writing a packet to it must be atomic. Previously, only
reading device's vacancy (before writing on it) or occupancy (before
reading from it) was locked. Hence, effectively reading the packet or
writing the packet wasn't locked at all. However, reading a packet (and
writing one, to a lesser extent) requires to read 3 different registers
in a specific order, without missing one or else we should reset the
device.

This patch fixes the device's locking mechanism on the FIFO character
device. As the device was using copy_from_user() and copy_to_user(), we
need to replace spinlocks with mutexes.

Signed-off-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
---
 drivers/staging/axis-fifo/axis-fifo.c | 160 ++++++++++++++++----------
 1 file changed, 101 insertions(+), 59 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-f=
ifo/axis-fifo.c
index 39e6c59df1e9..5801067e7c1b 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -16,7 +16,7 @@
=20
 #include <linux/kernel.h>
 #include <linux/wait.h>
-#include <linux/spinlock_types.h>
+#include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include <linux/init.h>
@@ -133,9 +133,9 @@ struct axis_fifo {
 	int has_tx_fifo; /* whether the IP has the tx fifo enabled */
=20
 	wait_queue_head_t read_queue; /* wait queue for asynchronos read */
-	spinlock_t read_queue_lock; /* lock for reading waitqueue */
+	struct mutex read_lock; /* lock for reading */
 	wait_queue_head_t write_queue; /* wait queue for asynchronos write */
-	spinlock_t write_queue_lock; /* lock for writing waitqueue */
+	struct mutex write_lock; /* lock for writing */
 	unsigned int write_flags; /* write file flags */
 	unsigned int read_flags; /* read file flags */
=20
@@ -336,7 +336,21 @@ static void reset_ip_core(struct axis_fifo *fifo)
 	iowrite32(XLLF_INT_ALL_MASK, fifo->base_addr + XLLF_ISR_OFFSET);
 }
=20
-/* reads a single packet from the fifo as dictated by the tlast signal */
+/**
+ * axis_fifo_write() - Read a packet from AXIS-FIFO character device.
+ * @f Open file.
+ * @buf User space buffer to read to.
+ * @len User space buffer length.
+ * @off Buffer offset.
+ *
+ * As defined by the device's documentation, we need to check the device's
+ * occupancy before reading the length register and then the data. All the=
se
+ * operations must be executed atomically, in order and one after the othe=
r
+ * without missing any.
+ *
+ * Returns the number of bytes read from the device or negative error code
+ *	on failure.
+ */
 static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 			      size_t len, loff_t *off)
 {
@@ -350,36 +364,37 @@ static ssize_t axis_fifo_read(struct file *f, char __=
user *buf,
 	u32 tmp_buf[READ_BUF_SIZE];
=20
 	if (fifo->read_flags & O_NONBLOCK) {
-		/* opened in non-blocking mode
-		 * return if there are no packets available
+		/*
+		 * Device opened in non-blocking mode. Try to lock it and then
+		 * check if any packet is available.
 		 */
-		if (!ioread32(fifo->base_addr + XLLF_RDFO_OFFSET))
+		if (!mutex_trylock(&fifo->read_lock))
 			return -EAGAIN;
+
+		if (!ioread32(fifo->base_addr + XLLF_RDFO_OFFSET)) {
+			ret =3D -EAGAIN;
+			goto end_unlock;
+		}
 	} else {
 		/* opened in blocking mode
 		 * wait for a packet available interrupt (or timeout)
 		 * if nothing is currently available
 		 */
-		spin_lock_irq(&fifo->read_queue_lock);
-		ret =3D wait_event_interruptible_lock_irq_timeout
-			(fifo->read_queue,
-			 ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
-			 fifo->read_queue_lock,
-			 (read_timeout >=3D 0) ? msecs_to_jiffies(read_timeout) :
+		mutex_lock(&fifo->read_lock);
+		ret =3D wait_event_interruptible_timeout(fifo->read_queue,
+			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
+			(read_timeout >=3D 0) ? msecs_to_jiffies(read_timeout) :
 				MAX_SCHEDULE_TIMEOUT);
-		spin_unlock_irq(&fifo->read_queue_lock);
=20
-		if (ret =3D=3D 0) {
-			/* timeout occurred */
-			dev_dbg(fifo->dt_device, "read timeout");
-			return -EAGAIN;
-		} else if (ret =3D=3D -ERESTARTSYS) {
-			/* signal received */
-			return -ERESTARTSYS;
-		} else if (ret < 0) {
-			dev_err(fifo->dt_device, "wait_event_interruptible_timeout() error in r=
ead (ret=3D%i)\n",
-				ret);
-			return ret;
+		if (ret <=3D 0) {
+			if (ret =3D=3D 0) {
+				ret =3D -EAGAIN;
+			} else if (ret !=3D -ERESTARTSYS) {
+				dev_err(fifo->dt_device, "wait_event_interruptible_timeout() error in =
read (ret=3D%i)\n",
+					ret);
+			}
+
+			goto end_unlock;
 		}
 	}
=20
@@ -387,14 +402,16 @@ static ssize_t axis_fifo_read(struct file *f, char __=
user *buf,
 	if (!bytes_available) {
 		dev_err(fifo->dt_device, "received a packet of length 0 - fifo core will=
 be reset\n");
 		reset_ip_core(fifo);
-		return -EIO;
+		ret =3D -EIO;
+		goto end_unlock;
 	}
=20
 	if (bytes_available > len) {
 		dev_err(fifo->dt_device, "user read buffer too small (available bytes=3D=
%zu user buffer bytes=3D%zu) - fifo core will be reset\n",
 			bytes_available, len);
 		reset_ip_core(fifo);
-		return -EINVAL;
+		ret =3D -EINVAL;
+		goto end_unlock;
 	}
=20
 	if (bytes_available % sizeof(u32)) {
@@ -403,7 +420,8 @@ static ssize_t axis_fifo_read(struct file *f, char __us=
er *buf,
 		 */
 		dev_err(fifo->dt_device, "received a packet that isn't word-aligned - fi=
fo core will be reset\n");
 		reset_ip_core(fifo);
-		return -EIO;
+		ret =3D -EIO;
+		goto end_unlock;
 	}
=20
 	words_available =3D bytes_available / sizeof(u32);
@@ -423,16 +441,37 @@ static ssize_t axis_fifo_read(struct file *f, char __=
user *buf,
 		if (copy_to_user(buf + copied * sizeof(u32), tmp_buf,
 				 copy * sizeof(u32))) {
 			reset_ip_core(fifo);
-			return -EFAULT;
+			ret =3D -EFAULT;
+			goto end_unlock;
 		}
=20
 		copied +=3D copy;
 		words_available -=3D copy;
 	}
=20
-	return bytes_available;
+	ret =3D bytes_available;
+
+end_unlock:
+	mutex_unlock(&fifo->read_lock);
+
+	return ret;
 }
=20
+/**
+ * axis_fifo_write() - Write buffer to AXIS-FIFO character device.
+ * @f Open file.
+ * @buf User space buffer to write to the device.
+ * @len User space buffer length.
+ * @off Buffer offset.
+ *
+ * As defined by the device's documentation, we need to write to the devic=
e's
+ * data buffer then to the device's packet length register atomically. Als=
o,
+ * we need to lock before checking if the device has available space to av=
oid
+ * any concurrency issue.
+ *
+ * Returns the number of bytes written to the device or negative error cod=
e
+ *	on failure.
+ */
 static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 			       size_t len, loff_t *off)
 {
@@ -465,12 +504,17 @@ static ssize_t axis_fifo_write(struct file *f, const =
char __user *buf,
 	}
=20
 	if (fifo->write_flags & O_NONBLOCK) {
-		/* opened in non-blocking mode
-		 * return if there is not enough room available in the fifo
+		/*
+		 * Device opened in non-blocking mode. Try to lock it and then
+		 * check if there is any room to write the given buffer.
 		 */
+		if (!mutex_trylock(&fifo->write_lock))
+			return -EAGAIN;
+
 		if (words_to_write > ioread32(fifo->base_addr +
 					      XLLF_TDFV_OFFSET)) {
-			return -EAGAIN;
+			ret =3D -EAGAIN;
+			goto end_unlock;
 		}
 	} else {
 		/* opened in blocking mode */
@@ -478,30 +522,22 @@ static ssize_t axis_fifo_write(struct file *f, const =
char __user *buf,
 		/* wait for an interrupt (or timeout) if there isn't
 		 * currently enough room in the fifo
 		 */
-		spin_lock_irq(&fifo->write_queue_lock);
-		ret =3D wait_event_interruptible_lock_irq_timeout
-			(fifo->write_queue,
-			 ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
+		mutex_lock(&fifo->write_lock);
+		ret =3D wait_event_interruptible_timeout(fifo->write_queue,
+			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
 				>=3D words_to_write,
-			 fifo->write_queue_lock,
-			 (write_timeout >=3D 0) ?
-				msecs_to_jiffies(write_timeout) :
+			(write_timeout >=3D 0) ? msecs_to_jiffies(write_timeout) :
 				MAX_SCHEDULE_TIMEOUT);
-		spin_unlock_irq(&fifo->write_queue_lock);
=20
-		if (ret =3D=3D 0) {
-			/* timeout occurred */
-			dev_dbg(fifo->dt_device, "write timeout\n");
-			return -EAGAIN;
-		} else if (ret =3D=3D -ERESTARTSYS) {
-			/* signal received */
-			return -ERESTARTSYS;
-		} else if (ret < 0) {
-			/* unknown error */
-			dev_err(fifo->dt_device,
-				"wait_event_interruptible_timeout() error in write (ret=3D%i)\n",
-				ret);
-			return ret;
+		if (ret <=3D 0) {
+			if (ret =3D=3D 0) {
+				ret =3D -EAGAIN;
+			} else if (ret !=3D -ERESTARTSYS) {
+				dev_err(fifo->dt_device, "wait_event_interruptible_timeout() error in =
write (ret=3D%i)\n",
+					ret);
+			}
+
+			goto end_unlock;
 		}
 	}
=20
@@ -515,7 +551,8 @@ static ssize_t axis_fifo_write(struct file *f, const ch=
ar __user *buf,
 		if (copy_from_user(tmp_buf, buf + copied * sizeof(u32),
 				   copy * sizeof(u32))) {
 			reset_ip_core(fifo);
-			return -EFAULT;
+			ret =3D -EFAULT;
+			goto end_unlock;
 		}
=20
 		for (i =3D 0; i < copy; i++)
@@ -526,10 +563,15 @@ static ssize_t axis_fifo_write(struct file *f, const =
char __user *buf,
 		words_to_write -=3D copy;
 	}
=20
+	ret =3D copied * sizeof(u32);
+
 	/* write packet size to fifo */
-	iowrite32(copied * sizeof(u32), fifo->base_addr + XLLF_TLR_OFFSET);
+	iowrite32(ret, fifo->base_addr + XLLF_TLR_OFFSET);
+
+end_unlock:
+	mutex_unlock(&fifo->write_lock);
=20
-	return (ssize_t)copied * sizeof(u32);
+	return ret;
 }
=20
 static irqreturn_t axis_fifo_irq(int irq, void *dw)
@@ -789,8 +831,8 @@ static int axis_fifo_probe(struct platform_device *pdev=
)
 	init_waitqueue_head(&fifo->read_queue);
 	init_waitqueue_head(&fifo->write_queue);
=20
-	spin_lock_init(&fifo->read_queue_lock);
-	spin_lock_init(&fifo->write_queue_lock);
+	mutex_init(&fifo->read_lock);
+	mutex_init(&fifo->write_lock);
=20
 	/* ----------------------------
 	 *   init device memory space
--=20
2.24.1

