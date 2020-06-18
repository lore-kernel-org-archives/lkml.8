Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F75C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25662207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgFRSMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:12:18 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:38966
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726001AbgFRSMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 14:12:16 -0400
X-IronPort-AV: E=Sophos;i="5.75,252,1589234400"; 
   d="scan'208";a="352037137"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 20:12:12 +0200
Date:   Thu, 18 Jun 2020 20:12:12 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Steven French <Steven.French@microsoft.com>
cc:     Ronnie Sahlberg <lsahlber@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>
Subject: Re: [EXTERNAL] fs/cifs/transport.c:1284:2-8: preceding lock on line
 1277 (fwd)
In-Reply-To: <MW2PR2101MB1019F18F3F11B5430EF0AAB0E49B0@MW2PR2101MB1019.namprd21.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2006182010310.2367@hadrien>
References: <alpine.DEB.2.22.394.2006181706350.2367@hadrien> <MW2PR2101MB1019F18F3F11B5430EF0AAB0E49B0@MW2PR2101MB1019.namprd21.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-316582898-1592503933=:2367"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-316582898-1592503933=:2367
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT



On Thu, 18 Jun 2020, Steven French wrote:

> Wasn't this fixed last year by:

It looks like it.  I received the message today from kbuild, but I didn't
look further than that.  Perhaps it is an old tree somehow.

julia


>
> commit 8bd3754cff3aa6e80e73cb56042cdc6f76d6510e
> Author: Dan Carpenter <dan.carpenter@oracle.com>
> Date:   Fri Oct 25 13:35:08 2019 +0300
>
>     cifs: rename a variable in SendReceive()
>    
>     Smatch gets confused because we sometimes refer to "server->srv_mutex"
> and
>     sometimes to "sess->server->srv_mutex".  They refer to the same lock so
>     let's just make this consistent.
>    
>     Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>     Signed-off-by: Steve French <stfrench@microsoft.com>
>
> diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
> index ca3de62688d6..f27842fb9f75 100644
> --- a/fs/cifs/transport.c
> +++ b/fs/cifs/transport.c
> @@ -1287,7 +1287,7 @@ SendReceive(const unsigned int xid, struct cifs_ses
> *ses,
>  
>         rc = allocate_mid(ses, in_buf, &midQ);
>         if (rc) {
> -               mutex_unlock(&ses->server->srv_mutex);
> +               mutex_unlock(&server->srv_mutex);
>                 /* Update # of requests on wire to server */
>                 add_credits(server, &credits, 0);
>                 return rc;
>
> ____________________________________________________________________________
> From: Julia Lawall <julia.lawall@inria.fr>
> Sent: Thursday, June 18, 2020 10:08 AM
> To: Ronnie Sahlberg <lsahlber@redhat.com>
> Cc: Steven French <Steven.French@microsoft.com>;
> linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>;
> kbuild-all@lists.01.org <kbuild-all@lists.01.org>
> Subject: [EXTERNAL] fs/cifs/transport.c:1284:2-8: preceding lock on line
> 1277 (fwd)  
> Hello,
>
> This is not actually a bug.  But for both tools and humans, it might be
> better to refer to the lock on line 1281 in the same way that it is
> referred to on line 1277.
>
> julia
>
> ---------- Forwarded message ----------
> Date: Thu, 18 Jun 2020 08:07:12 +0800
> From: kernel test robot <lkp@intel.com>
> To: kbuild@lists.01.org
> Cc: lkp@intel.com, Julia Lawall <julia.lawall@lip6.fr>
> Subject: fs/cifs/transport.c:1284:2-8: preceding lock on line 1277
>
> CC: kbuild-all@lists.01.org
> CC: linux-kernel@vger.kernel.org
> TO: Ronnie Sahlberg <lsahlber@redhat.com>
> CC: Steve French <stfrench@microsoft.com>
>
> tree:  https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kerne
> l.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;data=0
> 2%7C01%7CSteven.French%40microsoft.com%7C206f157b15804da9dad408d81399862d%
> 7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637280897690591644&amp;sdata=
> rglSnjoPRmT8g0Fj9k2jeCz11jZmXeUmB8W5vnD3LO4%3D&amp;reserved=0 master
> head:   1b5044021070efa3259f3e9548dc35d1eb6aa844
> commit: afe6f65353b644f55875d42d812ffe87f1887d68 cifs: add new debugging
> macro cifs_server_dbg
> date:   9 months ago
> :::::: branch date: 6 hours ago
> :::::: commit date: 9 months ago
> config: xtensa-randconfig-c024-20200617 (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
>
>
> coccinelle warnings: (new ones prefixed by >>)
>
> >> fs/cifs/transport.c:1284:2-8: preceding lock on line 1277
>
> #https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kerne
> l.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2
> F%3Fid%3Dafe6f65353b644f55875d42d812ffe87f1887d68&amp;data=02%7C01%7CSteve
> n.French%40microsoft.com%7C206f157b15804da9dad408d81399862d%7C72f988bf86f1
> 41af91ab2d7cd011db47%7C1%7C0%7C637280897690591644&amp;sdata=AeeIaHJgLjCns9
> aksXdMxnYone5UZVM3n2DREKL6N6c%3D&amp;reserved=0
> git remote add linushttps://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kerne
> l.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;data=0
> 2%7C01%7CSteven.French%40microsoft.com%7C206f157b15804da9dad408d81399862d%
> 7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637280897690601647&amp;sdata=
> K6zcUzaXsw9IkszPgZX66llW8857a9ApKU9e2Z9rDFY%3D&amp;reserved=0
> git remote update linus
> git checkout afe6f65353b644f55875d42d812ffe87f1887d68
> vim +1284 fs/cifs/transport.c
>
> 738f9de5cdb917 Pavel Shilovsky 2016-11-23  1233
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1234  int
> 96daf2b09178d8 Steve French    2011-05-27  1235  SendReceive(const unsigned
> int xid, struct cifs_ses *ses,
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1236              struct smb_hdr
> *in_buf, struct smb_hdr *out_buf,
> 480b1cb9dad894 Ronnie Sahlberg 2019-03-08  1237              int
> *pbytes_returned, const int flags)
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1238  {
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1239          int rc = 0;
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1240          struct mid_q_entry
> *midQ;
> fb2036d817584d Pavel Shilovsky 2016-11-23  1241          unsigned int len =
> be32_to_cpu(in_buf->smb_buf_length);
> fb2036d817584d Pavel Shilovsky 2016-11-23  1242          struct kvec iov = {
> .iov_base = in_buf, .iov_len = len };
> fb2036d817584d Pavel Shilovsky 2016-11-23  1243          struct smb_rqst
> rqst = { .rq_iov = &iov, .rq_nvec = 1 };
> 34f4deb7c56c6f Pavel Shilovsky 2019-01-16  1244          struct cifs_credits
> credits = { .value = 1, .instance = 0 };
> afe6f65353b644 Ronnie Sahlberg 2019-08-28  1245          struct
> TCP_Server_Info *server = ses->server;
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1246
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1247          if (ses == NULL) {
> f96637be081141 Joe Perches     2013-05-04  1248                 
> cifs_dbg(VFS, "Null smb session\n");
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1249                  return
> -EIO;
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1250          }
> afe6f65353b644 Ronnie Sahlberg 2019-08-28  1251          if (server == NULL)
> {
> f96637be081141 Joe Perches     2013-05-04  1252                 
> cifs_dbg(VFS, "Null tcp session\n");
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1253                  return
> -EIO;
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1254          }
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1255
> afe6f65353b644 Ronnie Sahlberg 2019-08-28  1256          if
> (server->tcpStatus == CifsExiting)
> 31ca3bc3c569f9 Steve French    2005-04-28  1257                  return
> -ENOENT;
> 31ca3bc3c569f9 Steve French    2005-04-28  1258
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1259          /* Ensure that we
> do not send more than 50 overlapping requests
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1260             to the same
> server. We may make this configurable later or
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1261             use ses->maxReq
> */
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1262
> fb2036d817584d Pavel Shilovsky 2016-11-23  1263          if (len >
> CIFSMaxBufSize + MAX_CIFS_HDR_SIZE - 4) {
> afe6f65353b644 Ronnie Sahlberg 2019-08-28  1264                 
> cifs_server_dbg(VFS, "Illegal length, greater than maximum frame, %d\n",
> fb2036d817584d Pavel Shilovsky 2016-11-23  1265                          
> len);
> 6d9c6d543165d1 Volker Lendecke 2008-12-08  1266                  return
> -EIO;
> 6d9c6d543165d1 Volker Lendecke 2008-12-08  1267          }
> 6d9c6d543165d1 Volker Lendecke 2008-12-08  1268
> afe6f65353b644 Ronnie Sahlberg 2019-08-28  1269          rc =
> wait_for_free_request(server, flags, &credits.instance);
> 7ee1af765dfa31 Jeremy Allison  2006-08-02  1270          if (rc)
> 7ee1af765dfa31 Jeremy Allison  2006-08-02  1271                  return rc;
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1272
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1273          /* make sure that
> we sign in the same order that we send on this socket
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1274             and avoid races
> inside tcp sendmsg code that could cause corruption
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1275             of smb data */
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1276
> afe6f65353b644 Ronnie Sahlberg 2019-08-28 @1277         
> mutex_lock(&server->srv_mutex);
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1278
> 7ee1af765dfa31 Jeremy Allison  2006-08-02  1279          rc =
> allocate_mid(ses, in_buf, &midQ);
> 7ee1af765dfa31 Jeremy Allison  2006-08-02  1280          if (rc) {
> 72ca545b2d83ac Jeff Layton     2008-12-01  1281                 
> mutex_unlock(&ses->server->srv_mutex);
> 7ee1af765dfa31 Jeremy Allison  2006-08-02  1282                  /* Update #
> of requests on wire to server */
> afe6f65353b644 Ronnie Sahlberg 2019-08-28  1283                 
> add_credits(server, &credits, 0);
> 7ee1af765dfa31 Jeremy Allison  2006-08-02 @1284                  return rc;
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1285          }
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1286
> afe6f65353b644 Ronnie Sahlberg 2019-08-28  1287          rc =
> cifs_sign_smb(in_buf, server, &midQ->sequence_number);
> 829049cbb1d2dd Volker Lendecke 2008-12-06  1288          if (rc) {
> afe6f65353b644 Ronnie Sahlberg 2019-08-28  1289                 
> mutex_unlock(&server->srv_mutex);
> 829049cbb1d2dd Volker Lendecke 2008-12-06  1290                  goto out;
> 829049cbb1d2dd Volker Lendecke 2008-12-06  1291          }
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  1292
> 7c9421e1a9ce8d Pavel Shilovsky 2012-03-23  1293          midQ->mid_state =
> MID_REQUEST_SUBMITTED;
> 789e66612367f9 Steve French    2011-08-09  1294
> afe6f65353b644 Ronnie Sahlberg 2019-08-28  1295         
> cifs_in_send_inc(server);
> afe6f65353b644 Ronnie Sahlberg 2019-08-28  1296          rc =
> smb_send(server, in_buf, len);
> afe6f65353b644 Ronnie Sahlberg 2019-08-28  1297         
> cifs_in_send_dec(server);
> 789e66612367f9 Steve French    2011-08-09  1298         
> cifs_save_when_sent(midQ);
> ad313cb86dfba2 Jeff Layton     2013-04-03  1299
> ad313cb86dfba2 Jeff Layton     2013-04-03  1300          if (rc < 0)
> afe6f65353b644 Ronnie Sahlberg 2019-08-28  1301                 
> server->sequence_number -= 2;
> ad313cb86dfba2 Jeff Layton     2013-04-03  1302
> afe6f65353b644 Ronnie Sahlberg 2019-08-28  1303         
> mutex_unlock(&server->srv_mutex);
> 7ee1af765dfa31 Jeremy Allison  2006-08-02  1304
> 7ee1af765dfa31 Jeremy Allison  2006-08-02  1305          if (rc < 0)
> 7ee1af765dfa31 Jeremy Allison  2006-08-02  1306                  goto out;
> 7ee1af765dfa31 Jeremy Allison  2006-08-02  1307
> afe6f65353b644 Ronnie Sahlberg 2019-08-28  1308          rc =
> wait_for_response(server, midQ);
> 1be912dde772b7 Jeff Layton     2011-01-28  1309          if (rc != 0) {
> afe6f65353b644 Ronnie Sahlberg 2019-08-28  1310                 
> send_cancel(server, &rqst, midQ);
> 1be912dde772b7 Jeff Layton     2011-01-28  1311                 
> spin_lock(&GlobalMid_Lock);
> 7c9421e1a9ce8d Pavel Shilovsky 2012-03-23  1312                  if
> (midQ->mid_state == MID_REQUEST_SUBMITTED) {
> 1be912dde772b7 Jeff Layton     2011-01-28  1313                          /*
> no longer considered to be "in-flight" */
> 1be912dde772b7 Jeff Layton     2011-01-28  1314                         
> midQ->callback = DeleteMidQEntry;
> 1be912dde772b7 Jeff Layton     2011-01-28  1315                         
> spin_unlock(&GlobalMid_Lock);
> afe6f65353b644 Ronnie Sahlberg 2019-08-28  1316                         
> add_credits(server, &credits, 0);
> 1be912dde772b7 Jeff Layton     2011-01-28  1317                         
> return rc;
> 1be912dde772b7 Jeff Layton     2011-01-28  1318                  }
> 1be912dde772b7 Jeff Layton     2011-01-28  1319                 
> spin_unlock(&GlobalMid_Lock);
> 1be912dde772b7 Jeff Layton     2011-01-28  1320          }
> 14a441a2b4ee1d Steve French    2006-07-16  1321
> afe6f65353b644 Ronnie Sahlberg 2019-08-28  1322          rc =
> cifs_sync_mid_result(midQ, server);
> 053d50344568e5 Jeff Layton     2011-01-11  1323          if (rc != 0) {
> afe6f65353b644 Ronnie Sahlberg 2019-08-28  1324                 
> add_credits(server, &credits, 0);
> 7ee1af765dfa31 Jeremy Allison  2006-08-02  1325                  return rc;
> 7ee1af765dfa31 Jeremy Allison  2006-08-02  1326          }
> 7ee1af765dfa31 Jeremy Allison  2006-08-02  1327
> 2c8f981d93f830 Jeff Layton     2011-05-19  1328          if (!midQ->resp_buf
> || !out_buf ||
> 7c9421e1a9ce8d Pavel Shilovsky 2012-03-23  1329              midQ->mid_state
> != MID_RESPONSE_RECEIVED) {
> 7ee1af765dfa31 Jeremy Allison  2006-08-02  1330                  rc = -EIO;
> afe6f65353b644 Ronnie Sahlberg 2019-08-28  1331                 
> cifs_server_dbg(VFS, "Bad MID state?\n");
> 2c8f981d93f830 Jeff Layton     2011-05-19  1332                  goto out;
> 7ee1af765dfa31 Jeremy Allison  2006-08-02  1333          }
> 7ee1af765dfa31 Jeremy Allison  2006-08-02  1334
> d4e4854fd1c85a Pavel Shilovsky 2012-03-23  1335          *pbytes_returned =
> get_rfc1002_length(midQ->resp_buf);
> 2c8f981d93f830 Jeff Layton     2011-05-19  1336          memcpy(out_buf,
> midQ->resp_buf, *pbytes_returned + 4);
> afe6f65353b644 Ronnie Sahlberg 2019-08-28  1337          rc =
> cifs_check_receive(midQ, server, 0);
> 7ee1af765dfa31 Jeremy Allison  2006-08-02  1338  out:
> 3c1bf7e48e9e46 Pavel Shilovsky 2012-09-18  1339         
> cifs_delete_mid(midQ);
> afe6f65353b644 Ronnie Sahlberg 2019-08-28  1340          add_credits(server,
> &credits, 0);
> 7ee1af765dfa31 Jeremy Allison  2006-08-02  1341
> 7ee1af765dfa31 Jeremy Allison  2006-08-02  1342          return rc;
> 7ee1af765dfa31 Jeremy Allison  2006-08-02  1343  }
> 7ee1af765dfa31 Jeremy Allison  2006-08-02  1344
>
> :::::: The code at line 1284 was first introduced by commit
> :::::: 7ee1af765dfa3146aef958258003245e082284e5 [CIFS]
>
> :::::: TO: Jeremy Allison <jra@samba.com>
> :::::: CC: Steve French <sfrench@us.ibm.com>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.01.
> org%2Fhyperkitty%2Flist%2Fkbuild-all%40lists.01.org&amp;data=02%7C01%7CSte
> ven.French%40microsoft.com%7C206f157b15804da9dad408d81399862d%7C72f988bf86
> f141af91ab2d7cd011db47%7C1%7C0%7C637280897690601647&amp;sdata=8ooAqMhFsu0W
> PNZHTqniPgiydgShTnlvnHtQMieY3Ao%3D&amp;reserved=0
>
>
--8323329-316582898-1592503933=:2367--
