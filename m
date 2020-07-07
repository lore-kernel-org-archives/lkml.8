Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF06C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE5FE206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594154943;
	bh=uAkFHQK6yPB+2Qs5NrOA8Ta45SXj/+e6B/FUQcVkvMc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Zjw8dG5Nn++Y36/x/cXTrI5QH7DdeqLA1g8uFMCvSzWQvcHxE9StRujKYbJpRZ3pC
	 C6iMmZIcmh6N3r90bUZysGFBiNKwGEcZnopDSK3LgWcUz19/5T9u5FrjEXFCFuAun3
	 7O/n1uiifylv7V25xoTf552xk55B7BGjiV8lEod8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgGGUtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:49:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgGGUtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:49:01 -0400
Received: from embeddedor (unknown [200.39.26.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9541C206BE;
        Tue,  7 Jul 2020 20:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594154939;
        bh=uAkFHQK6yPB+2Qs5NrOA8Ta45SXj/+e6B/FUQcVkvMc=;
        h=Date:From:To:Cc:Subject:From;
        b=xK6AI9UtQuF3grdsP89Mhb9lCPWE//gW/zS/farG4ZOxGDKJuwO9CvTrdi1zrmUDu
         TTwMUtJsoGAIus1iUDUi4+IYv+eEuDDooJhU3pp5NGhjoqRTP/sa+sxY4J2oJ9aqGf
         s7v6DKfiunhyZ6SGWrZY9h+kCwkDQBdi8hl92lwk=
Date:   Tue, 7 Jul 2020 15:54:26 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] afs: Use fallthrough pseudo-keyword
Message-ID: <20200707205426.GA11894@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
fall-through markings when it is the case.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/afs/cmservice.c |   16 ++++++++--------
 fs/afs/file.c      |    2 +-
 fs/afs/flock.c     |    1 -
 fs/afs/fsclient.c  |   10 +++++-----
 fs/afs/misc.c      |   18 +++++++++---------
 fs/afs/rotate.c    |    2 +-
 fs/afs/rxrpc.c     |    7 +++----
 fs/afs/vlclient.c  |   27 +++++++++++++++------------
 fs/afs/write.c     |    2 +-
 fs/afs/yfsclient.c |   16 ++++++++--------
 10 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index bef413818af7..a4e9e6e07e93 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -252,7 +252,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		call->unmarshall++;
 
 		/* extract the FID array and its count in two steps */
-		/* fall through */
+		fallthrough;
 	case 1:
 		_debug("extract FID count");
 		ret = afs_extract_data(call, true);
@@ -271,7 +271,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		afs_extract_to_buf(call, call->count * 3 * 4);
 		call->unmarshall++;
 
-		/* Fall through */
+		fallthrough;
 	case 2:
 		_debug("extract FID array");
 		ret = afs_extract_data(call, true);
@@ -297,7 +297,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		call->unmarshall++;
 
 		/* extract the callback array and its count in two steps */
-		/* fall through */
+		fallthrough;
 	case 3:
 		_debug("extract CB count");
 		ret = afs_extract_data(call, true);
@@ -312,7 +312,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		iov_iter_discard(&call->def_iter, READ, call->count2 * 3 * 4);
 		call->unmarshall++;
 
-		/* Fall through */
+		fallthrough;
 	case 4:
 		_debug("extract discard %zu/%u",
 		       iov_iter_count(call->iter), call->count2 * 3 * 4);
@@ -391,7 +391,7 @@ static int afs_deliver_cb_init_call_back_state3(struct afs_call *call)
 		afs_extract_to_buf(call, 11 * sizeof(__be32));
 		call->unmarshall++;
 
-		/* Fall through */
+		fallthrough;
 	case 1:
 		_debug("extract UUID");
 		ret = afs_extract_data(call, false);
@@ -503,7 +503,7 @@ static int afs_deliver_cb_probe_uuid(struct afs_call *call)
 		afs_extract_to_buf(call, 11 * sizeof(__be32));
 		call->unmarshall++;
 
-		/* Fall through */
+		fallthrough;
 	case 1:
 		_debug("extract UUID");
 		ret = afs_extract_data(call, false);
@@ -618,7 +618,7 @@ static int afs_deliver_yfs_cb_callback(struct afs_call *call)
 		call->unmarshall++;
 
 		/* extract the FID array and its count in two steps */
-		/* Fall through */
+		fallthrough;
 	case 1:
 		_debug("extract FID count");
 		ret = afs_extract_data(call, true);
@@ -637,7 +637,7 @@ static int afs_deliver_yfs_cb_callback(struct afs_call *call)
 		afs_extract_to_buf(call, size);
 		call->unmarshall++;
 
-		/* Fall through */
+		fallthrough;
 	case 2:
 		_debug("extract FID array");
 		ret = afs_extract_data(call, false);
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 6f6ed1605cfe..cfa3b36b462d 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -310,8 +310,8 @@ int afs_page_filler(void *data, struct page *page)
 		/* page will not be cached */
 	case -ENOBUFS:
 		_debug("cache said ENOBUFS");
+		fallthrough;
 
-		/* fall through */
 	default:
 	go_on:
 		req = kzalloc(struct_size(req, array, 1), GFP_KERNEL);
diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index ffb8575345ca..cb3054c7843e 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -376,7 +376,6 @@ void afs_lock_work(struct work_struct *work)
 		spin_unlock(&vnode->lock);
 		return;
 
-		/* Fall through */
 	default:
 		/* Looks like a lock request was withdrawn. */
 		spin_unlock(&vnode->lock);
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index acb4d0ca2649..0b88a87c3be7 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -348,7 +348,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		call->bvec[0].bv_page = req->pages[req->index];
 		iov_iter_bvec(&call->def_iter, READ, call->bvec, 1, size);
 		ASSERTCMP(size, <=, PAGE_SIZE);
-		/* Fall through */
+		fallthrough;
 
 		/* extract the returned data */
 	case 2:
@@ -375,7 +375,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		/* Discard any excess data the server gave us */
 		afs_extract_discard(call, req->actual_len - req->len);
 		call->unmarshall = 3;
-		/* Fall through */
+		fallthrough;
 
 	case 3:
 		_debug("extract discard %zu/%llu",
@@ -1794,7 +1794,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		call->unmarshall++;
 	more_counts:
 		afs_extract_to_buf(call, 21 * sizeof(__be32));
-		/* Fall through */
+		fallthrough;
 
 	case 2:
 		_debug("extract status array %u", call->count);
@@ -1841,7 +1841,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		call->unmarshall++;
 	more_cbs:
 		afs_extract_to_buf(call, 3 * sizeof(__be32));
-		/* Fall through */
+		fallthrough;
 
 	case 4:
 		_debug("extract CB array");
@@ -1870,7 +1870,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 
 		afs_extract_to_buf(call, 6 * sizeof(__be32));
 		call->unmarshall++;
-		/* Fall through */
+		fallthrough;
 
 	case 5:
 		ret = afs_extract_data(call, false);
diff --git a/fs/afs/misc.c b/fs/afs/misc.c
index 5334f1bd2bca..1d1a8debe472 100644
--- a/fs/afs/misc.c
+++ b/fs/afs/misc.c
@@ -120,42 +120,42 @@ void afs_prioritise_error(struct afs_error *e, int error, u32 abort_code)
 		if (e->error == -ETIMEDOUT ||
 		    e->error == -ETIME)
 			return;
-		/* Fall through */
+		fallthrough;
 	case -ETIMEDOUT:
 	case -ETIME:
 		if (e->error == -ENOMEM ||
 		    e->error == -ENONET)
 			return;
-		/* Fall through */
+		fallthrough;
 	case -ENOMEM:
 	case -ENONET:
 		if (e->error == -ERFKILL)
 			return;
-		/* Fall through */
+		fallthrough;
 	case -ERFKILL:
 		if (e->error == -EADDRNOTAVAIL)
 			return;
-		/* Fall through */
+		fallthrough;
 	case -EADDRNOTAVAIL:
 		if (e->error == -ENETUNREACH)
 			return;
-		/* Fall through */
+		fallthrough;
 	case -ENETUNREACH:
 		if (e->error == -EHOSTUNREACH)
 			return;
-		/* Fall through */
+		fallthrough;
 	case -EHOSTUNREACH:
 		if (e->error == -EHOSTDOWN)
 			return;
-		/* Fall through */
+		fallthrough;
 	case -EHOSTDOWN:
 		if (e->error == -ECONNREFUSED)
 			return;
-		/* Fall through */
+		fallthrough;
 	case -ECONNREFUSED:
 		if (e->error == -ECONNRESET)
 			return;
-		/* Fall through */
+		fallthrough;
 	case -ECONNRESET: /* Responded, but call expired. */
 		if (e->responded)
 			return;
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 6a0935cb822f..d83f13c44b92 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -281,7 +281,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 	case -ETIME:
 		if (op->error != -EDESTADDRREQ)
 			goto iterate_address;
-		/* Fall through */
+		fallthrough;
 	case -ERFKILL:
 	case -EADDRNOTAVAIL:
 	case -ENETUNREACH:
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 8fc8fb406a5a..6eecc83ba19a 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -568,7 +568,7 @@ static void afs_deliver_to_call(struct afs_call *call)
 		case -EIO:
 			pr_err("kAFS: Call %u in bad state %u\n",
 			       call->debug_id, state);
-			/* Fall through */
+			fallthrough;
 		case -ENODATA:
 		case -EBADMSG:
 		case -EMSGSIZE:
@@ -668,8 +668,7 @@ long afs_wait_for_call_to_complete(struct afs_call *call,
 	case 0:
 		ret = call->ret0;
 		call->ret0 = 0;
-
-		/* Fall through */
+		fallthrough;
 	case -ECONNABORTED:
 		ac->responded = true;
 		break;
@@ -872,7 +871,7 @@ void afs_send_empty_reply(struct afs_call *call)
 		_debug("oom");
 		rxrpc_kernel_abort_call(net->socket, call->rxcall,
 					RX_USER_ABORT, -ENOMEM, "KOO");
-		/* Fall through */
+		fallthrough;
 	default:
 		_leave(" [error]");
 		return;
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index fd82850cd424..d8ab81cfc5b9 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -196,7 +196,8 @@ static int afs_deliver_vl_get_addrs_u(struct afs_call *call)
 
 		/* Extract the returned uuid, uniquifier, nentries and
 		 * blkaddrs size */
-		/* Fall through */
+		fallthrough;
+
 	case 1:
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -220,8 +221,8 @@ static int afs_deliver_vl_get_addrs_u(struct afs_call *call)
 	more_entries:
 		count = min(call->count, 4U);
 		afs_extract_to_buf(call, count * sizeof(__be32));
+		fallthrough;	/* and extract entries */
 
-		/* Fall through - and extract entries */
 	case 2:
 		ret = afs_extract_data(call, call->count > 4);
 		if (ret < 0)
@@ -323,8 +324,8 @@ static int afs_deliver_vl_get_capabilities(struct afs_call *call)
 	case 0:
 		afs_extract_to_tmp(call);
 		call->unmarshall++;
+		fallthrough;	/* and extract the capabilities word count */
 
-		/* Fall through - and extract the capabilities word count */
 	case 1:
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -336,8 +337,8 @@ static int afs_deliver_vl_get_capabilities(struct afs_call *call)
 
 		call->unmarshall++;
 		afs_extract_discard(call, count * sizeof(__be32));
+		fallthrough;	/* and extract capabilities words */
 
-		/* Fall through - and extract capabilities words */
 	case 2:
 		ret = afs_extract_data(call, false);
 		if (ret < 0)
@@ -436,7 +437,8 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		/* Extract the returned uuid, uniquifier, fsEndpoints count and
 		 * either the first fsEndpoint type or the volEndpoints
 		 * count if there are no fsEndpoints. */
-		/* Fall through */
+		fallthrough;
+
 	case 1:
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -474,8 +476,8 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		size += sizeof(__be32);
 		afs_extract_to_buf(call, size);
 		call->unmarshall = 2;
+		fallthrough;	/* and extract fsEndpoints[] entries */
 
-		/* Fall through - and extract fsEndpoints[] entries */
 	case 2:
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -526,7 +528,8 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		 * extract the type of the next endpoint when we extract the
 		 * data of the current one, but this is the first...
 		 */
-		/* Fall through */
+		fallthrough;
+
 	case 3:
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -551,8 +554,8 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 			size += sizeof(__be32); /* Get next type too */
 		afs_extract_to_buf(call, size);
 		call->unmarshall = 4;
+		fallthrough;	/* and extract volEndpoints[] entries */
 
-		/* Fall through - and extract volEndpoints[] entries */
 	case 4:
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -586,8 +589,8 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 	end:
 		afs_extract_discard(call, 0);
 		call->unmarshall = 5;
+		fallthrough;	/* Done */
 
-		/* Fall through - Done */
 	case 5:
 		ret = afs_extract_data(call, false);
 		if (ret < 0)
@@ -662,8 +665,8 @@ static int afs_deliver_yfsvl_get_cell_name(struct afs_call *call)
 	case 0:
 		afs_extract_to_tmp(call);
 		call->unmarshall++;
+		fallthrough;	/* and extract the cell name length */
 
-		/* Fall through - and extract the cell name length */
 	case 1:
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -684,8 +687,8 @@ static int afs_deliver_yfsvl_get_cell_name(struct afs_call *call)
 
 		afs_extract_begin(call, cell_name, namesz);
 		call->unmarshall++;
+		fallthrough;	/* and extract cell name */
 
-		/* Fall through - and extract cell name */
 	case 2:
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -693,8 +696,8 @@ static int afs_deliver_yfsvl_get_cell_name(struct afs_call *call)
 
 		afs_extract_discard(call, call->count2);
 		call->unmarshall++;
+		fallthrough;	/* and extract padding */
 
-		/* Fall through - and extract padding */
 	case 3:
 		ret = afs_extract_data(call, false);
 		if (ret < 0)
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 7437806332d9..4e6809c45022 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -608,7 +608,7 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 
 	default:
 		pr_notice("kAFS: Unexpected error from FS.StoreData %d\n", ret);
-		/* Fall through */
+		fallthrough;
 	case -EACCES:
 	case -EPERM:
 	case -ENOKEY:
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 8c24fdc899e3..439e9cd86395 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -428,7 +428,7 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 		/* Discard any excess data the server gave us */
 		afs_extract_discard(call, req->actual_len - req->len);
 		call->unmarshall = 3;
-		/* Fall through */
+		fallthrough;
 
 	case 3:
 		_debug("extract discard %zu/%llu",
@@ -461,7 +461,7 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 		req->file_size = vp->scb.status.size;
 
 		call->unmarshall++;
-		/* Fall through */
+		fallthrough;
 
 	case 5:
 		break;
@@ -1363,7 +1363,7 @@ static int yfs_deliver_fs_get_volume_status(struct afs_call *call)
 		_debug("motd '%s'", p);
 
 		call->unmarshall++;
-		/* Fall through */
+		fallthrough;
 
 	case 8:
 		break;
@@ -1640,7 +1640,7 @@ static int yfs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		call->unmarshall++;
 	more_counts:
 		afs_extract_to_buf(call, sizeof(struct yfs_xdr_YFSFetchStatus));
-		/* Fall through */
+		fallthrough;
 
 	case 2:
 		_debug("extract status array %u", call->count);
@@ -1687,7 +1687,7 @@ static int yfs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		call->unmarshall++;
 	more_cbs:
 		afs_extract_to_buf(call, sizeof(struct yfs_xdr_YFSCallBack));
-		/* Fall through */
+		fallthrough;
 
 	case 4:
 		_debug("extract CB array");
@@ -1716,7 +1716,7 @@ static int yfs_deliver_fs_inline_bulk_status(struct afs_call *call)
 
 		afs_extract_to_buf(call, sizeof(struct yfs_xdr_YFSVolSync));
 		call->unmarshall++;
-		/* Fall through */
+		fallthrough;
 
 	case 5:
 		ret = afs_extract_data(call, false);
@@ -1727,7 +1727,7 @@ static int yfs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		xdr_decode_YFSVolSync(&bp, &op->volsync);
 
 		call->unmarshall++;
-		/* Fall through */
+		fallthrough;
 
 	case 6:
 		break;
@@ -1886,7 +1886,7 @@ static int yfs_deliver_fs_fetch_opaque_acl(struct afs_call *call)
 		xdr_decode_YFSVolSync(&bp, &op->volsync);
 
 		call->unmarshall++;
-		/* Fall through */
+		fallthrough;
 
 	case 6:
 		break;

